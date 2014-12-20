#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <jni.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <signal.h>
#include <unistd.h>
#include <fcntl.h>
#include <ctype.h>

const char *conf_path = "", *conf_shell = "", *conf_home = "";

/* NB - this will leak memory like crazy if called often.... */
const char *
conf_path_file(const char *fn)
{
	char *ret = malloc(strlen(conf_path)+strlen(fn)+20);
	sprintf(ret, "%s/%s", conf_path, fn);
	return ret;
}


static JNIEnv *env;
static jclass cl_string;
static jclass cl_simplesshdservice;
static jfieldID fid_sss_sshd_pid;

extern int dropbear_main(int argc, char **argv);

static int
jni_init(JNIEnv *env_)
{
	env = env_;
#define CLASS(var, id) \
	cl_##var = (*env)->FindClass(env, id); \
	if (!cl_##var) return 0;
#define METHOD(var, mycl, id, sig) \
	mid_##var = (*env)->GetMethodID(env, cl_##mycl, id, sig); \
	if (!mid_##var) return 0;
#define FIELD(var, mycl, id, sig) \
	fid_##var = (*env)->GetFieldID(env, cl_##mycl, id, sig); \
	if (!fid_##var) return 0;
#define STFIELD(var, mycl, id, sig) \
	fid_##var = (*env)->GetStaticFieldID(env, cl_##mycl, id, sig); \
	if (!fid_##var) return 0;

	CLASS(string, "java/lang/String")
	CLASS(simplesshdservice, "org/galexander/sshd/SimpleSSHDService")

	STFIELD(sss_sshd_pid, simplesshdservice, "sshd_pid", "I")

	return 1;
}

/* split str into argv entries, honoring " and \ (but nothing else) */
static int
process_extra(const char *in, char **argv, int max_argc)
{
	char curr[1000];
	int curr_len = 0;
	int in_quotes = 0;
	int argc = 0;

	if (!in) {
		return 0;
	}
	while (1) {
		char c = *in++;
		if (!c || (curr_len+10 >= sizeof curr) ||
		    (!in_quotes && isspace(c))) {
			if (curr_len) {
				curr[curr_len] = 0;
				if (argc+1 >= max_argc) {
					break;
				}
				argv[argc++] = strdup(curr);
				curr_len = 0;
			}
			if (!c) {
				break;
			}
		} else if (c == '"') {
			in_quotes = !in_quotes;
		} else {
			if (c == '\\') {
				c = *in++;
				switch (c) {
					case 'n': c = '\n'; break;
					case 'r': c = '\r'; break;
					case 'b': c = '\b'; break;
					case 't': c = '\t'; break;
					case 0: in--; break;
				}
			}
			curr[curr_len++] = c;
		}
	}
	return argc;
}

static const char *
from_java_string(jobject s)
{
	const char *ret, *t;
	t = (*env)->GetStringUTFChars(env, s, NULL);
	if (!t) {
		return "";
	}
	ret = strdup(t);
	(*env)->ReleaseStringUTFChars(env, s, t);
	return ret;
}

JNIEXPORT void JNICALL
Java_org_galexander_sshd_SimpleSSHDService_start_1sshd(JNIEnv *env_,
	jclass cl,
	jint port, jobject jpath, jobject jshell, jobject jhome, jobject jextra)
{
	pid_t pid;
	const char *extra;

	if (!jni_init(env_)) {
		return;
	}
	conf_path = from_java_string(jpath);
	conf_shell = from_java_string(jshell);
	conf_home = from_java_string(jhome);
	extra = from_java_string(jextra);

	pid = fork();
	if (pid == 0) {
		char *argv[100] = { "sshd", NULL };
		int argc = 1;
		const char *logfn;
		int logfd;
		int retval;
		int i;

		logfn = conf_path_file("dropbear.err");
		unlink(logfn);
		logfd = open(logfn, O_CREAT|O_WRONLY, 0666);
		if (logfd != -1) {
			/* replace stderr, so the output is preserved... */
			dup2(logfd, 2);
		}
		for (i = 3; i < 255; i++) {
			/* close all of the dozens of fds that android typically
			 * leaves open */
			close(i);
		}

		argv[argc++] = "-R";	/* enable DROPBEAR_DELAY_HOSTKEY */
		argv[argc++] = "-F";	/* don't redundant fork to background */
		if (port) {
			argv[argc++] = "-p";
			argv[argc] = malloc(20);
			sprintf(argv[argc], "%d", (int)port);
			argc++;
		}
		argc += process_extra(extra, &argv[argc],
				(sizeof argv / sizeof *argv) - argc);
		fprintf(stderr, "starting dropbear\n");
		retval = dropbear_main(argc, argv);
		fprintf(stderr, "dropbear finished (%d)\n", retval);
	} else {
		(*env)->SetStaticIntField(env, cl_simplesshdservice,
					fid_sss_sshd_pid, pid);
	}
}

JNIEXPORT void JNICALL
Java_org_galexander_sshd_SimpleSSHDService_stop_1sshd(JNIEnv *env_, jclass cl)
{
	pid_t pid;
	if (!jni_init(env_)) {
		return;
	}
	pid = (*env)->GetStaticIntField(env, cl_simplesshdservice, fid_sss_sshd_pid);
	kill(pid, SIGKILL);
	(*env)->SetStaticIntField(env, cl_simplesshdservice, fid_sss_sshd_pid, 0);
}

JNIEXPORT int JNICALL
Java_org_galexander_sshd_SimpleSSHDService_waitpid(JNIEnv *env_, jclass cl,
			jint pid)
{
	int status;
	waitpid(pid, &status, 0);
	if (WIFEXITED(status)) {
		return WEXITSTATUS(status);
	}
	return 0;
}
