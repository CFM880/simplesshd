package org.galexander.sshd;

import android.app.Service;

public class SimpleSSHDService extends Service {
	public int sshd_pid = 0;

	public int onStartCommand(Intent intent, int flags, int startId) {
		if ((intent == null) ||
		    (!intent.getBooleanExtra("stop", false)) {
			if (is_started()) {
				stop_sshd();
			}
			start_sshd();
			return START_STICKY;
		} else {
			stop_sshd();
			return START_NOT_STICKY;
		}
	}

	public boolean is_started() {
		return (sshd_pid != 0);
	}

	private native void start_sshd(void);
	private native void stop_sshd(void);
	static {
		System.loadLibrary("simplesshd-jni");
	}
}
