package org.galexander.sshd;

import java.io.File;

public class UpdaterThread extends Thread {
	/* poll for changes to the dropbear.err file */
	public void run() {
		File f = new File(Prefs.get_path(), "dropbear.err");
		long lastmod = 0;
		long lastlen = 0;
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
			long mod = f.lastModified();
			long len = f.length();
			if (mod != lastmod) {
System.out.println("sshd: updating for time");
				SimpleSSHD.curr.runOnUiThread(new Thread() {
					public void run() {
						SimpleSSHD.curr.update_log();
					}
				});
				lastmod = mod;
				lastlen = len;
			}
			if (len != lastlen) {
System.out.println("sshd: updating for len");
				SimpleSSHD.curr.runOnUiThread(new Thread() {
					public void run() {
						SimpleSSHD.curr.update_log();
					}
				});
				lastmod = mod;
				lastlen = len;
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
