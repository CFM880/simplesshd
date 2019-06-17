package org.galexander.sshd;

import android.content.BroadcastReceiver;
import android.content.Intent;
import android.content.Context;
import android.os.Build;
import android.widget.Toast;


public class BootReceiver extends BroadcastReceiver {
	public void onReceive(Context context, Intent intent) {
		Prefs.init(context);
		if (Prefs.get_onboot()) {
			Intent i = new Intent(context, SimpleSSHDService.class);
			if (Build.VERSION.SDK_INT >=
					Build.VERSION_CODES.O) {
				if (Prefs.get_foreground()) {
					context.startForegroundService(i);
				} else {
					Toast.makeText(context,
"SimpleSSHD cannot start background at boot since Oreo (see Settings).",
						Toast.LENGTH_LONG).show();
				}
			} else {
				context.startService(i);
			}
		}
	}
}
