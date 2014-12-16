package org.galexander.sshd;

import android.app.Service;
import android.content.Intent;
import android.content.Context;
import android.os.IBinder;

public class SimpleSSHDService extends Service {
	public static int sshd_pid = 0;
	public static SimpleSSHD activity = null;

	public void onCreate() {
		super.onCreate();
		Prefs.init(this);
	}

	public int onStartCommand(Intent intent, int flags, int startId) {
		if ((intent == null) ||
		    (!intent.getBooleanExtra("stop", false))) {
			do_start();
/* XXX - maybe we should call startForeground(), but then we'd have to make a
 * bogus notification... */
			return START_STICKY;
		} else {
			stop_sshd();
			update_activity();
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
			Prefs.get_home());

		if (sshd_pid != 0) {
			final int pid = sshd_pid;
			(new Thread() {
				public void run() {
					waitpid(pid);
					if (sshd_pid == pid) {
						sshd_pid = 0;
					}
					update_activity();
				}
			}).start();
		}
		update_activity();
	}

	private static void update_activity() {
		if (activity != null) {
			activity.runOnUiThread(new Runnable() {
				public void run() {
					activity.update_startstop();
				}
			});
		}
	}

	private native void start_sshd(int port, String path,
			String shell, String home);
	private native void stop_sshd();
	private static native int waitpid(int pid);
	static {
		System.loadLibrary("simplesshd-jni");
	}
}
