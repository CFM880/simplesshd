#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <jni.h>
#include <sys/types.h>
#include <signal.h>
#include <unistd.h>
#include <fcntl.h>

const char *conf_path, *conf_shell, *conf_home;

/* XXX - do i need a function to generate host keys? DROPBEAR_DELAY_HOSTKEY */
/* XXX - a C-callable interface to get property strings from the java side (paths, etc) */

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
	jobject this,
	jint port, jobject jpath, jobject jshell, jobject jhome)
{
	pid_t pid;

	if (!jni_init(env_)) {
		return;
	}
	conf_path = from_java_string(jpath);
	conf_shell = from_java_string(jshell);
	conf_home = from_java_string(jhome);

	pid = fork();
	if (pid == 0) {
		char *argv[10] = { "sshd", NULL };
		int argc = 1;
		char *logfn;
		int logfd;

		logfn = malloc(strlen(conf_path)+20);
		sprintf(logfn, "%s/dropbear.err", conf_path);
		unlink(logfn);
		logfd = open(logfn, O_CREAT|O_WRONLY, 0666);
		if (logfd != -1) {
			/* replace stderr, so the output is preserved... */
			dup2(logfd, 2);
		}
		if (port) {
			argv[argc++] = "-p";
			argv[argc] = malloc(20);
			sprintf(argv[argc], "%d", (int)port);
			argc++;
		}
		dropbear_main(1, argv);
	} else {
		(*env)->SetStaticIntField(env, cl_simplesshdservice,
					fid_sss_sshd_pid, pid);
	}
}

JNIEXPORT void JNICALL
Java_org_galexander_sshd_SimpleSSHDService_stop_1sshd(JNIEnv *env_, jobject this)
{
	pid_t pid;
	if (!jni_init(env_)) {
		return;
	}
	pid = (*env)->GetStaticIntField(env, cl_simplesshdservice, fid_sss_sshd_pid);
	kill(pid, SIGKILL);
	(*env)->SetStaticIntField(env, cl_simplesshdservice, fid_sss_sshd_pid, 0);
}
