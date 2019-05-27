package org.galexander.sshd;

import android.app.Notification;
import android.app.NotificationChannel;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Intent;
import android.content.Context;
import android.os.Build;
import android.os.IBinder;
import android.widget.RemoteViews;
import androidx.core.app.NotificationCompat;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

public class SimpleSSHDService extends Service {
		/* if restarting twice within 10 seconds, give up */
	private static final int MIN_DURATION = 10000;

	private static final Object lock = new Object();
	private static int sshd_pid = 0;
	private static long sshd_when = 0;
	private static long sshd_duration = 0;
	private static boolean foregrounded = false;
	private static String libdir = null;

	public void onCreate() {
		super.onCreate();

		Prefs.init(this);

		read_pidfile();

		stop_sshd();	/* it would be stale anyways */
	}

	public int onStartCommand(Intent intent, int flags, int startId) {
		libdir = getApplicationInfo().nativeLibraryDir;
		if ((intent == null) ||
		    (!intent.getBooleanExtra("stop", false))) {
			do_start();
			do_foreground();
			return START_STICKY;
		} else {
			stop_sshd();
			stop_service();
			SimpleSSHD.update_startstop();
			return START_NOT_STICKY;
		}
	}

	public IBinder onBind(Intent intent) {
		return null;
	}

		/* unfortunately, android doesn't reliably call this when, i.e.,
		 * the package is upgraded... so it's really pretty useless */
	public void onDestroy() {
		stop_sshd();
		stop_service();
		super.onDestroy();
	}

	private void do_foreground() {
		foregrounded = Prefs.get_foreground();
		if (foregrounded) {
			create_notification_channel();

			RemoteViews rv = new RemoteViews(getPackageName(),
					R.layout.notification);
			rv.setImageViewResource(R.id.n_icon, R.drawable.icon);
			rv.setTextViewText(R.id.n_text,
				"SimpleSSHD listening on " +
				SimpleSSHD.get_ip(false) +
				":" + Prefs.get_port());
			PendingIntent pi = PendingIntent.getActivity(this, 0,
				new Intent(this, SimpleSSHD.class),
				PendingIntent.FLAG_UPDATE_CURRENT);
			Notification n = new NotificationCompat.Builder(
						this, "main")
				.setSmallIcon(R.drawable.notification_icon)
				.setTicker("SimpleSSHD")
				.setContent(rv)
				.setContentIntent(pi)
				.setOngoing(true)
				.setPriority(NotificationCompat.PRIORITY_LOW)
				.setLocalOnly(true)
				.setVisibility(
					NotificationCompat.VISIBILITY_PUBLIC)
				.build();
			startForeground(1, n);
		}
	}

	private void create_notification_channel() {
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
			NotificationChannel nc = new NotificationChannel(
				"main", "SimpleSSHD",
				NotificationManager.IMPORTANCE_LOW);
			nc.enableLights(false);
			nc.enableVibration(false);
			nc.setSound(null, null);
			getSystemService(NotificationManager.class)
				.createNotificationChannel(nc);
		}
	}

	public static boolean is_started() {
		return (sshd_pid != 0);
	}

	private static void stop_sshd() {
		int pid;
		synchronized (lock) {
			pid = sshd_pid;
			sshd_pid = 0;
		}
		if (pid != 0) {
			kill(pid);
		}
	}

	private void stop_service() {
		stopSelf();
		if (foregrounded) {
			stopForeground(true);
			foregrounded = false;
		}
	}

	private static void maybe_restart(int pid) {
		boolean do_restart = false;
		long now = System.currentTimeMillis();
		synchronized (lock) {
			if (sshd_pid == pid) {
				sshd_pid = 0;
				do_restart =
					((sshd_duration == 0) ||
					 (sshd_when == 0) ||
					 (sshd_duration >= MIN_DURATION) ||
					 ((now-sshd_when) >= MIN_DURATION));
			}
		}
		if (do_restart) {
			do_start();
		}
	}

	private static void do_start() {
		stop_sshd();
		new File(Prefs.get_path()).mkdirs();
		final int pid = start_sshd(Prefs.get_port(),
			Prefs.get_path(), Prefs.get_shell(),
			Prefs.get_home(), Prefs.get_extra(),
			(Prefs.get_rsyncbuffer() ? 1 : 0),
			Prefs.get_env(), libdir);

		long now = System.currentTimeMillis();
		if (pid != 0) {
			synchronized (lock) {
				stop_sshd();
				sshd_pid = pid;
				sshd_duration = ((sshd_when != 0)
						? (now - sshd_when) : 0);
				sshd_when = now;
			}
			(new Thread() {
				public void run() {
					waitpid(pid);
					maybe_restart(pid);
					SimpleSSHD.update_startstop();
				}
			}).start();
		}
		SimpleSSHD.update_startstop();
	}

	private static void read_pidfile() {
		try {
			File f = new File(Prefs.get_path(), "dropbear.pid");
			int pid = 0;
			if (f.exists()) {
				BufferedReader r = new BufferedReader(
							new FileReader(f));
				try {
					pid =
						Integer.valueOf(r.readLine());
				} finally {
					r.close();
				}
			}
			if (pid != 0) {
				synchronized (lock) {
					stop_sshd();
					sshd_pid = pid;
					sshd_when = System.currentTimeMillis();
					sshd_duration = 0;
				}
			}
		} catch (Exception e) { /* *shrug* */ }
	}

	private static native int start_sshd(int port, String path,
			String shell, String home, String extra,
			int rsyncbuffer, String env, String lib);
	private static native void kill(int pid);
	private static native int waitpid(int pid);
	static {
		System.loadLibrary("simplesshd-jni");
	}
}
