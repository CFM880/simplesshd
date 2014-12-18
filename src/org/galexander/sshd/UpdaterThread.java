package org.galexander.sshd;

import java.io.File;

public class UpdaterThread extends Thread {
	/* poll for changes to the dropbear.err file */
	public void run() {
		File f = new File(Prefs.get_path(), "dropbear.err");
		long lastmod = 0;
System.out.println("sshd: updater start");
		while (true) {
			if (isInterrupted()) {
System.out.println("sshd: updater interrupted");
				break;
			}
			if (SimpleSSHD.curr == null) {
System.out.println("sshd: activity stopped");
				break;
			}
			long l = f.lastModified();
			if (l != lastmod) {
System.out.println("sshd: updating");
				SimpleSSHD.curr.runOnUiThread(new Thread() {
					public void run() {
						SimpleSSHD.curr.update_log();
					}
				});
				lastmod = l;
			}
			try {
				sleep(1000);
			} catch (InterruptedException e) {
System.out.println("sshd: sleep interrupted");
				break;
			}
		}
System.out.println("sshd: done");
	}
}
