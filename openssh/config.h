#define HAVE_U_INT 1
#define HAVE_INTXX_T 1
#define HAVE_U_INTXX_T 1
#define HAVE_UINTXX_T 1
#define HAVE_INTMAX_T 1
#define HAVE_UINTMAX_T 1
#define HAVE_U_CHAR 1
#define HAVE_SIZE_T 1
#define HAVE_SSIZE_T 1
#define HAVE_CLOCK_T 1
#define HAVE_SA_FAMILY_T 1
#define HAVE_PID_T 1
#define HAVE_MODE_T 1
#define GETPGRP_VOID 1
#define HAVE___func__ 1
#define HAVE_LIMITS_H 1
#define HAVE_UTIMES 1
#define HAVE_STRUCT_TIMEVAL 1
#define HAVE_NANOSLEEP 1
#define HAVE_STRUCT_TIMESPEC 1
#define HAVE_SNPRINTF 1
#define HAVE_SIG_ATOMIC_T 1
#define HAVE_MBLEN 1
#define HAVE_SYS_UN_H 1

#define error(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
#define fatal(fmt, ...) { fprintf(stderr, fmt, ##__VA_ARGS__); cleanup_exit(255); }
