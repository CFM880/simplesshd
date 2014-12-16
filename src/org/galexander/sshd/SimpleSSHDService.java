package org.galexander.sshd;

import android.app.Service;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.Context;
import android.os.IBinder;
import android.preference.PreferenceManager;

public class SimpleSSHDService extends Service {
	public static int sshd_pid = 0;
	public static SimpleSSHD activity = null;

	public int onStartCommand(Intent intent, int flags, int startId) {
		if ((intent == null) ||
		    (!intent.getBooleanExtra("stop", false))) {
			SharedPreferences p = PreferenceManager.
					getDefaultSharedPreferences(this);
			if (is_started()) {
				stop_sshd();
			}
			start_sshd(SimpleSSHD.get_port(p),
				SimpleSSHD.get_path(p), SimpleSSHD.get_shell(p),
				SimpleSSHD.get_home(p));
			if (activity != null) {
				activity.update_startstop();
			}
			return START_STICKY;
		} else {
			stop_sshd();
			if (activity != null) {
				activity.update_startstop();
			}
			return START_NOT_STICKY;
		}
	}
	public IBinder onBind(Intent intent) {
		return null;
	}

	public static boolean is_started() {
		return (sshd_pid != 0);
	}

	private native void start_sshd(int port, String path,
			String shell, String home);
	private native void stop_sshd();
	static {
		System.loadLibrary("simplesshd-jni");
	}
}
