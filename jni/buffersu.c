#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/select.h>
#include <signal.h>
#include <fcntl.h>
#include <sys/wait.h>

#define WRAPPED_CMD "/data/data/org.galexander.sshd/lib/librsync.so"
#define WRAPPED_ARG0 "rsync"
#define MAX_BUFSZ (1024*1024)


static void
die(void)
{
	int status;
	waitpid(-1, &status, WNOHANG);
	exit(0);
}

static volatile int child_dead = 0;
static volatile pid_t child_pid = 0;

static void
sigchld(int sig)
{
	int status;
	waitpid(-1, &status, WNOHANG);
	/* don't exit, in case child has unprocessed output */
	child_dead = 1;
}

static void
sigpipe(int sig)
{
	kill(child_pid, SIGPIPE);
	die();
}

#define BLKSZ 1024
struct block {
	struct block *next;
	struct block *prev;
	char buf[BLKSZ];
	int ofs,len;
};
struct buf {
	struct block *head;	/* read here */
	struct block *tail;	/* write here */
};

static int
buf_length(struct buf *b)
{
	struct block *p;
	int ret = 0;
	for (p = b->head; p; p = p->next) {
		ret += p->len;
	}
	return ret;
}

static int
buf_waiting(struct buf *b)
{
	return (b->head != NULL);
}

static int
buf_read(struct buf *b, int fd)
{
	struct block *p;
	char t[BLKSZ];
	int n;

	n = read(fd, t, BLKSZ);
	if (n < 0) {
		perror("read");
		die();
	}
	if (n == 0) {
		/* EOF */
		return 0;
	}
	p = malloc(sizeof *p);
	memcpy(p->buf, t, BLKSZ);
	p->next = NULL;
	p->prev = b->tail;
	if (b->tail) {
		b->tail->next = p;
	}
	p->ofs = 0;
	p->len = n;
	b->tail = p;
	if (!b->head) {
		b->head = p;
	}
	return n;
}

static void
buf_write(struct buf *b, int fd)
{
	struct block *p;
	int n;

	if (!b->head) {
		return;
	}
	p = b->head;

	n = write(fd, p->buf+p->ofs, p->len);
	if (n <= 0) {
		perror("write");
		return;
	}
	p->ofs += n;
	p->len -= n;
	if (p->len <= 0) {
		if (p->next) {
			b->head = p->next;
			p->next->prev = NULL;
		} else {
			b->head = NULL;
			b->tail = NULL;
		}
		free(p);
	}
}

int
main(int argc, char **argv)
{
	int p0[2], p1[2];
	pid_t pid;
	pipe(p0);
	pipe(p1);
	if ((pid=fork())) {
		/* parent */
		fd_set ifds, ofds;
		int child_stdin, child_stdout;
		struct buf buf0 = { 0 };
		struct buf buf1 = { 0 };
		int nfd = 2;

		close(p0[0]);
		close(p1[1]);

		if (pid == -1) {
			perror("fork");
			return -1;
		}
		child_pid = pid;

		signal(SIGPIPE, sigpipe);
		signal(SIGCHLD, sigchld);

		child_stdin = p0[1];
		child_stdout = p1[0];
		if (child_stdin > nfd) nfd = child_stdin;
		if (child_stdout > nfd) nfd = child_stdout;
		nfd++;
		while (1) {
			int s;
			FD_ZERO(&ifds);
			if (buf_length(&buf0) < MAX_BUFSZ) {
				FD_SET(0, &ifds);
			}
			if (buf_length(&buf1) < MAX_BUFSZ) {
				FD_SET(child_stdout, &ifds);
			}
			FD_ZERO(&ofds);
			if (buf_waiting(&buf1)) {
				FD_SET(1, &ofds);
			} else if (child_dead) {
				die();
			}
			if (!child_dead && buf_waiting(&buf0)) {
				FD_SET(child_stdin, &ofds);
			}
			s = select(nfd, &ifds, &ofds, NULL, NULL);
			if (s < 0) {
				perror("select");
			}
#if 0
fprintf(stderr, "select %d\n", s);
#define T(x) \
if (FD_ISSET(0, &x##s)) fprintf(stderr, #x " 0\n"); \
if (FD_ISSET(1, &x##s)) fprintf(stderr, #x " 1\n"); \
if (FD_ISSET(child_stdin, &x##s)) fprintf(stderr, #x " child_stdin\n"); \
if (FD_ISSET(child_stdout, &x##s)) fprintf(stderr, #x " child_stdout\n");
T(ifd)
T(ofd)
#endif
			if (FD_ISSET(0, &ifds)) {
				buf_read(&buf0, 0);
			}
			if (FD_ISSET(child_stdout, &ifds)) {
				if (!buf_read(&buf1, child_stdout)) {
					child_dead = 1;
				}
			}
			if (FD_ISSET(1, &ofds)) {
				buf_write(&buf1, 1);
			}
			if (!child_dead && FD_ISSET(child_stdin, &ofds)) {
				buf_write(&buf0, child_stdin);
			}
		}
		die();
	} else {
		/* child */
		char **child_argv;
		close(0);
		close(1);
		dup2(p0[0], 0);
		dup2(p1[1], 1);
		close(p0[0]);
		close(p0[1]);
		close(p1[0]);
		close(p1[1]);
		child_argv = malloc((argc+1) * sizeof *child_argv);
		memcpy(child_argv, argv, argc*sizeof *child_argv);
		child_argv[0] = WRAPPED_ARG0;
		child_argv[argc] = NULL;
		execv(WRAPPED_CMD, child_argv);
		perror("execv");
		return -1;
	}
	return 0;
}
