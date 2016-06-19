package org.galexander.sshd;

import android.app.IntentService;
import android.content.Intent;
import java.io.File;
import java.io.FileOutputStream;

public class AuthKeysSave extends IntentService {
	public AuthKeysSave() {
		super("SimpleSSHDAuthKeysSave");
	}
	protected void onHandleIntent(Intent i) {
		String s = i.getStringExtra("s");
		if (s == null) {
			return;
		}
		try {
			File p = new File(Prefs.get_path());
			if (!p.exists()) {
				p.mkdirs();
			}
			File f = new File(p, "authorized_keys");
                        FileOutputStream fos = new FileOutputStream(f);
			int ofs = 0;

			try {
				fos.write(s.getBytes());
			} finally {
				fos.close();
			}
		} catch (Exception e) {
			SimpleSSHD.toast(
				"authorized_keys save failed: "+e.getMessage());
		}
	}
}
