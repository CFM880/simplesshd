/* config for dropbear embedded in SimpleSSHD */
#ifndef __CONFIG_H__
#define __CONFIG_H__ 1

#define HAVE_U_INT8_T 1
#define HAVE_U_INT16_T 1
#define HAVE_U_INT32_T 1
#define HAVE_UINT8_T 1
#define HAVE_UINT16_T 1
#define HAVE_UINT32_T 1

#define HAVE_STRUCT_SOCKADDR_STORAGE 1
#define HAVE_STRUCT_IN6_ADDR 1
#define HAVE_STRUCT_SOCKADDR_IN6 1
#define HAVE_STRUCT_ADDRINFO 1
#define HAVE_GETADDRINFO 1
#define HAVE_FREEADDRINFO 1
#define HAVE_GETNAMEINFO 1
#define HAVE_FORK 1
#define HAVE_GAI_STRERROR 1

#define HAVE_BASENAME 1
#define HAVE_NETINET_TCP_H 1
#define HAVE_LIBGEN_H 1
#define USE_DEV_PTMX 1

#undef DISABLE_ZLIB
#define DISABLE_SYSLOG 1


#define DROPBEAR_SERVER 1
#define DBMULTI_dropbear 1
#define DROPBEAR_MULTI 1

#define NDK_EXECUTABLES_PATH "/data/data/org.galexander.sshd/lib"


/* in jni/interface.c: */
extern const char *conf_path;
extern const char *conf_shell;
extern const char *conf_home;
const char *conf_path_file(const char *fn);
extern int conf_rsyncbuffer;
extern const char *conf_env;


#endif /* __CONFIG_H__ */
