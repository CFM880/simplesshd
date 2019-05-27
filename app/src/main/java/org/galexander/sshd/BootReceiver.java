package org.galexander.sshd;

import android.content.BroadcastReceiver;
import android.content.Intent;
import android.content.Context;
import android.os.Build;

public class BootReceiver extends BroadcastReceiver {
	public void onReceive(Context context, Intent intent) {
		Prefs.init(context);
		if (Prefs.get_onboot()) {
			Intent i = new Intent(context, SimpleSSHDService.class);
			if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
				/* Oreo won't allow a background service here */
				context.startForegroundService(i);
			} else {
				context.startService(i);
			}
		}
	}
}
