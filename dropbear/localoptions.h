
#ifndef DROPBEAR_DEFPORT
#define DROPBEAR_DEFPORT "2222"
#endif

#ifndef DROPBEAR_DEFADDRESS
/* Listen on all interfaces */
#define DROPBEAR_DEFADDRESS ""
#endif

/* Default hostkey paths - these can be specified on the command line */
#ifndef DSS_PRIV_FILENAME
#define DSS_PRIV_FILENAME conf_path_file("dropbear_dss_host_key")
#endif
#ifndef RSA_PRIV_FILENAME
#define RSA_PRIV_FILENAME conf_path_file("dropbear_rsa_host_key")
#endif
#ifndef ECDSA_PRIV_FILENAME
#define ECDSA_PRIV_FILENAME conf_path_file("dropbear_ecdsa_host_key")
#endif

/* Set NON_INETD_MODE if you require daemon functionality (ie Dropbear listens
 * on chosen ports and keeps accepting connections. This is the default.
 *
 * Set INETD_MODE if you want to be able to run Dropbear with inetd (or
 * similar), where it will use stdin/stdout for connections, and each process
 * lasts for a single connection. Dropbear should be invoked with the -i flag
 * for inetd, and can only accept IPv4 connections.
 *
 * Both of these flags can be defined at once, don't compile without at least
 * one of them. */
#define NON_INETD_MODE 1
#define INETD_MODE 0

/* Setting this disables the fast exptmod bignum code. It saves ~5kB, but is
 * perhaps 20% slower for pubkey operations (it is probably worth experimenting
 * if you want to use this) */
/*#define NO_FAST_EXPTMOD*/

/* Set this if you want to use the DROPBEAR_SMALL_CODE option. This can save
several kB in binary size however will make the symmetrical ciphers and hashes
slower, perhaps by 50%. Recommended for small systems that aren't doing
much traffic. */
#define DROPBEAR_SMALL_CODE 0

/* Enable X11 Forwarding - server only */
#define DROPBEAR_X11FWD 0

/* Enable TCP Fowarding */
/* 'Local' is "-L" style (client listening port forwarded via server)
 * 'Remote' is "-R" style (server listening port forwarded via client) */

#define DROPBEAR_CLI_LOCALTCPFWD 0
#define DROPBEAR_CLI_REMOTETCPFWD 0

#define DROPBEAR_SVR_LOCALTCPFWD 1
#define DROPBEAR_SVR_REMOTETCPFWD 1

/* Enable Authentication Agent Forwarding */
#define DROPBEAR_SVR_AGENTFWD 0
#define DROPBEAR_CLI_AGENTFWD 0


/* Note: Both DROPBEAR_CLI_PROXYCMD and DROPBEAR_CLI_NETCAT must be set to
 * allow multihop dbclient connections */

/* Allow using -J <proxycommand> to run the connection through a 
   pipe to a program, rather the normal TCP connection */
#define DROPBEAR_CLI_PROXYCMD 0

/* Enable "Netcat mode" option. This will forward standard input/output
 * to a remote TCP-forwarded connection */
#define DROPBEAR_CLI_NETCAT 0

/* Whether to support "-c" and "-m" flags to choose ciphers/MACs at runtime */
#define DROPBEAR_USER_ALGO_LIST 0

/* Encryption - at least one required.
 * Protocol RFC requires 3DES and recommends AES128 for interoperability.
 * Including multiple keysize variants the same cipher 
 * (eg AES256 as well as AES128) will result in a minimal size increase.*/
#define DROPBEAR_AES128 1
#define DROPBEAR_3DES 1
#define DROPBEAR_AES256 1
/* Compiling in Blowfish will add ~6kB to runtime heap memory usage */
#define DROPBEAR_BLOWFISH 1
#define DROPBEAR_TWOFISH256 1
#define DROPBEAR_TWOFISH128 1

/* Enable "Counter Mode" for ciphers. This is more secure than normal
 * CBC mode against certain attacks. This adds around 1kB to binary 
 * size and is recommended for most cases */
#define DROPBEAR_ENABLE_CTR_MODE 1

/* You can compile with no encryption if you want. In some circumstances
 * this could be safe security-wise, though make sure you know what
 * you're doing. Anyone can see everything that goes over the wire, so
 * the only safe auth method is public key. */
/* #define DROPBEAR_NONE_CIPHER */

/* Message Integrity - at least one required.
 * Protocol RFC requires sha1 and recommends sha1-96.
 * sha1-96 is of use for slow links as it has a smaller overhead.
 *
 * There's no reason to disable sha1 or sha1-96 to save space since it's
 * used for the random number generator and public-key cryptography anyway.
 * Disabling it here will just stop it from being used as the integrity portion
 * of the ssh protocol.
 *
 * These hashes are also used for public key fingerprints in logs.
 * If you disable MD5, Dropbear will fall back to SHA1 fingerprints,
 * which are not the standard form. */
#define DROPBEAR_SHA1_HMAC 1
#define DROPBEAR_SHA1_96_HMAC 1
#define DROPBEAR_SHA2_256_HMAC 1
#define DROPBEAR_SHA2_512_HMAC 1
#define DROPBEAR_MD5_HMAC 1

/* You can also disable integrity. Don't bother disabling this if you're
 * still using a cipher, it's relatively cheap. If you disable this it's dead
 * simple for an attacker to run arbitrary commands on the remote host. Beware. */
/* #define DROPBEAR_NONE_INTEGRITY */

/* Hostkey/public key algorithms - at least one required, these are used
 * for hostkey as well as for verifying signatures with pubkey auth.
 * Removing either of these won't save very much space.
 * SSH2 RFC Draft requires dss, recommends rsa */
#define DROPBEAR_RSA 1
#define DROPBEAR_DSS 1
/* ECDSA is significantly faster than RSA or DSS. Compiling in ECC
 * code (either ECDSA or ECDH) increases binary size - around 30kB
 * on x86-64 */
#define DROPBEAR_ECDSA 1

/* Generate hostkeys as-needed when the first connection using that key type occurs.
   This avoids the need to otherwise run "dropbearkey" and avoids some problems
   with badly seeded /dev/urandom when systems first boot.
   This also requires a runtime flag "-R". This adds ~4kB to binary size (or hardly 
   anything if dropbearkey is linked in a "dropbearmulti" binary) */
#define DROPBEAR_DELAY_HOSTKEY 1

/* Enable Curve25519 for key exchange. This is another elliptic
 * curve method with good security properties. Increases binary size
 * by ~8kB on x86-64 */
#define DROPBEAR_CURVE25519 1

/* Enable elliptic curve Diffie Hellman key exchange, see note about
 * ECDSA above */
#define DROPBEAR_ECDH 1

/* Control the memory/performance/compression tradeoff for zlib.
 * Set windowBits=8 for least memory usage, see your system's
 * zlib.h for full details.
 * Default settings (windowBits=15) will use 256kB for compression
 * windowBits=8 will use 129kB for compression.
 * Both modes will use ~35kB for decompression (using windowBits=15 for
 * interoperability) */
#define DROPBEAR_ZLIB_WINDOW_BITS 15 

/* Whether to do reverse DNS lookups. */
#define DO_HOST_LOOKUP 0

/* Whether to print the message of the day (MOTD). This doesn't add much code
 * size */
#define DO_MOTD 0

/* The MOTD file path */
#ifndef MOTD_FILENAME
#define MOTD_FILENAME "/etc/motd"
#endif

/* Authentication Types - at least one required.
   RFC Draft requires pubkey auth, and recommends password */
#define DROPBEAR_SVR_PASSWORD_AUTH 0

/* Note: PAM auth is quite simple and only works for PAM modules which just do
 * a simple "Login: " "Password: " (you can edit the strings in svr-authpam.c).
 * It's useful for systems like OS X where standard password crypts don't work
 * but there's an interface via a PAM module. It won't work for more complex
 * PAM challenge/response.
 * You can't enable both PASSWORD and PAM. */

/* PAM requires ./configure --enable-pam */
#define DROPBEAR_SVR_PAM_AUTH 0
#define DROPBEAR_SVR_PUBKEY_AUTH 1

/* Whether to take public key options in 
 * authorized_keys file into account */
#ifdef ENABLE_SVR_PUBKEY_AUTH
#define ENABLE_SVR_PUBKEY_OPTIONS
#endif

#define DROPBEAR_CLI_PASSWORD_AUTH 0
#define DROPBEAR_CLI_PUBKEY_AUTH 0

/* This variable can be used to set a password for client
 * authentication on the commandline. Beware of platforms
 * that don't protect environment variables of processes etc. Also
 * note that it will be provided for all "hidden" client-interactive
 * style prompts - if you want something more sophisticated, use 
 * SSH_ASKPASS instead. Comment out this var to remove this functionality.*/
#define DROPBEAR_PASSWORD_ENV 0

/* Define this (as well as ENABLE_CLI_PASSWORD_AUTH) to allow the use of
 * a helper program for the ssh client. The helper program should be
 * specified in the SSH_ASKPASS environment variable, and dbclient
 * should be run with DISPLAY set and no tty. The program should
 * return the password on standard output */
#define DROPBEAR_CLI_ASKPASS_HELPER 0

/* Save a network roundtrip by sendng a real auth request immediately after
 * sending a query for the available methods.  It is at the expense of < 100
 * bytes of extra network traffic. This is not yet enabled by default since it
 * could cause problems with non-compliant servers */
#define DROPBEAR_CLI_IMMEDIATE_AUTH 0

/* Source for randomness. This must be able to provide hundreds of bytes per SSH
 * connection without blocking. In addition /dev/random is used for seeding
 * rsa/dss key generation */
#define DROPBEAR_URANDOM_DEV "/dev/urandom"

/* Set this to use PRNGD or EGD instead of /dev/urandom or /dev/random */
#define DROPBEAR_USE_PRNGD 0
/*#define DROPBEAR_PRNGD_SOCKET "/var/run/dropbear-rng"*/


/* Specify the number of clients we will allow to be connected but
 * not yet authenticated. After this limit, connections are rejected */
/* The first setting is per-IP, to avoid denial of service */
#ifndef MAX_UNAUTH_PER_IP
#define MAX_UNAUTH_PER_IP 5
#endif

/* And then a global limit to avoid chewing memory if connections 
 * come from many IPs */
#ifndef MAX_UNAUTH_CLIENTS
#define MAX_UNAUTH_CLIENTS 30
#endif

/* Maximum number of failed authentication tries (server option) */
#ifndef MAX_AUTH_TRIES
#define MAX_AUTH_TRIES 10
#endif

/* The default file to store the daemon's process ID, for shutdown
   scripts etc. This can be overridden with the -P flag */
#define DROPBEAR_PIDFILE ((char *)conf_path_file("dropbear.pid"))

/* The command to invoke for xauth when using X11 forwarding.
 * "-q" for quiet */
#define XAUTH_COMMAND 0

#define SFTPSERVER_PATH "%s/libsftp-server.so" /*, conf_lib */

/* This is used by the scp binary when used as a client binary. If you're
 * not using the Dropbear client, you'll need to change it */
#define DROPBEAR_PATH_SSH_PROGRAM "/dev/null"

/* Whether to log commands executed by a client. This only logs the 
 * (single) command sent to the server, not what a user did in a 
 * shell/sftp session etc. */
#define LOG_COMMANDS 0

/* Window size limits. These tend to be a trade-off between memory
   usage and network performance: */
/* Size of the network receive window. This amount of memory is allocated
   as a per-channel receive buffer. Increasing this value can make a
   significant difference to network performance. 24kB was empirically
   chosen for a 100mbit ethernet network. The value can be altered at
   runtime with the -W argument. */
#ifndef DEFAULT_RECV_WINDOW
#define DEFAULT_RECV_WINDOW 24576
#endif
/* Maximum size of a received SSH data packet - this _MUST_ be >= 32768
   in order to interoperate with other implementations */
#ifndef RECV_MAX_PAYLOAD_LEN
#define RECV_MAX_PAYLOAD_LEN 32768
#endif
/* Maximum size of a transmitted data packet - this can be any value,
   though increasing it may not make a significant difference. */
#ifndef TRANS_MAX_PAYLOAD_LEN
#define TRANS_MAX_PAYLOAD_LEN 16384
#endif

/* Ensure that data is transmitted every KEEPALIVE seconds. This can
be overridden at runtime with -K. 0 disables keepalives */
#define DEFAULT_KEEPALIVE 0

/* If this many KEEPALIVES are sent with no packets received from the
other side, exit. Not run-time configurable - if you have a need
for runtime configuration please mail the Dropbear list */
#define DEFAULT_KEEPALIVE_LIMIT 3

/* Ensure that data is received within IDLE_TIMEOUT seconds. This can
be overridden at runtime with -I. 0 disables idle timeouts */
#define DEFAULT_IDLE_TIMEOUT 0

/* The default path. This will often get replaced by the shell */
#define DEFAULT_PATH "/sbin:/system/sbin:/system/bin:/system/xbin"
