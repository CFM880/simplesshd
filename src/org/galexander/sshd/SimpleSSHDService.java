package org.galexander.sshd;

import android.app.Service;
import android.content.Intent;
import android.content.Context;
import android.os.IBinder;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

public class SimpleSSHDService extends Service {
	public static int sshd_pid = 0;

	public void onCreate() {
		super.onCreate();

		Prefs.init(this);

		read_pidfile();
		if (is_started()) {
			/* would prefer to restart the daemon process rather
			 * than leave the stale one around.. */
			stop_sshd();
		}
	}

	public int onStartCommand(Intent intent, int flags, int startId) {
		if ((intent == null) ||
		    (!intent.getBooleanExtra("stop", false))) {
			do_start();
/* XXX - maybe we should call startForeground(), but then we'd have to make a
 * bogus notification... and START_STICKY seems to actually do a good job of
 * restarting us if we're killed...  */
			return START_STICKY;
		} else {
			stop_sshd();
			SimpleSSHD.update_startstop();
			stopSelf();
/* XXX - need stopForeground() too ? */
			return START_NOT_STICKY;
		}
	}

	public IBinder onBind(Intent intent) {
		return null;
	}

		/* unfortunately, android doesn't reliably call this when, i.e.,
		 * the package is upgraded... so it's really pretty useless */
	public void onDestroy() {
		if (is_started()) {
			stop_sshd();
		}
		stopSelf();
		super.onDestroy();
	}

	public static boolean is_started() {
		return (sshd_pid != 0);
	}

	private void do_start() {
		if (is_started()) {
			stop_sshd();
		}
		start_sshd(Prefs.get_port(),
			Prefs.get_path(), Prefs.get_shell(),
			Prefs.get_home(), Prefs.get_extra(),
			(Prefs.get_rsyncbuffer() ? 1 : 0));

		if (sshd_pid != 0) {
			final int pid = sshd_pid;
			(new Thread() {
				public void run() {
					waitpid(pid);
					if (sshd_pid == pid) {
						sshd_pid = 0;
					}
					SimpleSSHD.update_startstop();
				}
			}).start();
		}
		SimpleSSHD.update_startstop();
	}

	private static void read_pidfile() {
		try {
			File f = new File(Prefs.get_path(), "dropbear.pid");
			if (f.exists()) {
				BufferedReader r = new BufferedReader(
							new FileReader(f));
				try {
					sshd_pid =
						Integer.valueOf(r.readLine());
				} finally {
					r.close();
				}
			}
		} catch (Exception e) { /* *shrug* */ }
	}

	private static native void start_sshd(int port, String path,
			String shell, String home, String extra,
			int rsyncbuffer);
	private static native void stop_sshd();
	private static native int waitpid(int pid);
	static {
		System.loadLibrary("simplesshd-jni");
	}
}
