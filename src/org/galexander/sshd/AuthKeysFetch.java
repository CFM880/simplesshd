package org.galexander.sshd;

import android.app.IntentService;
import android.content.Intent;
import android.os.Message;
import android.os.Messenger;
import java.io.InputStream;
import java.net.URL;
import java.net.HttpURLConnection;


public class AuthKeysFetch extends IntentService {
	public AuthKeysFetch() {
		super("SimpleSSHDAuthKeysFetch");
	}
	protected void onHandleIntent(Intent i) {
		Messenger m = (Messenger)i.getParcelableExtra("m");
		Message msg = Message.obtain();
		String url = i.getStringExtra("url");

		String result = "";
		byte[] b = new byte[1024];

		try {
			if (url == null) {
				throw new Exception("no url");
			}
			URL u = new URL(url);
			HttpURLConnection conn = (HttpURLConnection)
					u.openConnection();
			try {
				InputStream in = conn.getInputStream();
				try {
					while (result.length() < 65536) {
						int r = in.read(b);
						if (r <= 0) {
							break;
						}
						result += new String(b, 0, r);
					}
				} finally {
					in.close();
				}
			} finally {
				conn.disconnect();
			}
			if (result.equals("")) {
				throw new Exception("empty file");
			}
			msg.arg1 = 0;
			msg.obj = result;
		} catch (Exception e) {
			msg.arg1 = 1;
			msg.obj = "HTTP fetch: " + e.getMessage();
		}
		try {
			m.send(msg);
		} catch (Exception e) { }
	}
}
