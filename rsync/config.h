#ifndef __RSYNC_CONFIG_H
#define __RSYNC_CONFIG_H 1

#define HAVE_ID_T 1
#define HAVE_PID_T 1
#define HAVE_MODE_T 1
#define HAVE_OFF_T 1
#define SIZEOF_INT32_T 4
#define SIZEOF_UINT32_T 4
#define HAVE_STRUCT_SOCKADDR_STORAGE 1
#define HAVE_SYS_TYPES_H 1
#define HAVE_SYS_STAT_H 1
#define STDC_HEADERS 1
#define HAVE_STDLIB_H 1
#define HAVE_STRING_H 1
#define HAVE_INTTYPES_H 1
#define HAVE_STDINT_H 1
#define HAVE_UNISTD_H 1
#define HAVE_SYS_PARAM_H 1
#define HAVE_SYS_SOCKET_H 1
#define TIME_WITH_SYS_TIME 1
#define HAVE_FCNTL_H 1
#define HAVE_CTYPE_H 1
#define HAVE_UTIME_H 1
#define RETSIGTYPE void
#define HAVE_ERRNO_DECL 1
#define HAVE_DIRENT_H 1
#define HAVE_SYS_WAIT_H 1
#define RSYNC_RSH "ssh"
#define HAVE_UTIMES 1
#define RSYNC_VERSION "3.1.1"
#define RSYNC_PATH "rsync"
#define SIZEOF_OFF_T 4
#define RSYNCD_SYSCONF "/sdcard/ssh/rsyncd.conf"
#define HAVE_NETDB_H 1
#define HAVE_STRUCT_ADDRINFO 1
#define HAVE_STRDUP 1
#define HAVE_GETCWD 1
#define HAVE_WAITPID 1
#define HAVE_MEMMOVE 1
#define HAVE_STRPBRK 1
#define HAVE_STRLCPY 1
#define HAVE_STRLCAT 1
#define HAVE_GETTIMEOFDAY_TZ 1
#define HAVE_STRERROR 1
#define HAVE_STRCHR 1
#define HAVE_GETADDRINFO 1
#define HAVE_CHMOD 1
#define HAVE_SIGACTION 1
/* Bionic supplies sigprocmask() but in Android Oreo and beyond, it seems to be:
 *    fprintf(stderr, "Bad system call\n");
 *    exit(0);
 * When it should probably be:
 *    errno=ENOSYS;
 *    return -1;
 * WTF, Bionic.
#define HAVE_SIGPROCMASK 1
*/
#define SUPPORT_LINKS 1
#define SUPPORT_HARD_LINKS 1
#define HAVE_LINK 1
#define HAVE_FTRUNCATE 1
#define HAVE_MKFIFO 1
#define HAVE_LCHOWN 1
#define HAVE_SOCKADDR_UN_LEN 1
#define HAVE_MKNOD 1
#define HAVE_FCHMOD 1
#define HAVE_SETMODE 1
#define HAVE_LSEEK64 1
#define HAVE_UTIMES 1
#define SIZEOF_OFF64_T 8
#define HAVE_READLINK 1
#define HAVE_SECURE_MKSTEMP 1
#define HAVE_FCHMOD 1
#define HAVE_SETMODE 1
#define HAVE_STRUCT_STAT64 1

#endif /* __RSYNC_CONFIG_H */
