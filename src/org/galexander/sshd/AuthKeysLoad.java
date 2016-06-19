package org.galexander.sshd;

import android.app.Activity;
import android.os.AsyncTask;

public class AuthKeysLoad extends AsyncTask<Void,Void,Void> {
	private AuthKeys act = null;
	private String result = null;
	private String error = null;

	public static void go(AuthKeys act_) {
		(new AuthKeysLoad(act_)).execute();
	}

	AuthKeysLoad(AuthKeys act_) {
		act = act_;
		super();
	}

	protected Void doInBackground(Void... v) {
		try {
			File f = new File(Prefs.get_path(), "authorized_keys");
			FileInputStream fis = new FileInputStream(f);

			byte b[] = new byte[1024];

			result = "";
			try {
				while (true) {
					int r = fis.read(b);
					if (r <= 0) {
						break;
					}
					result += new String(b, 0, r);
				}
			} finally {
				fis.close();
			}
		} catch (Exception e) {
			error = e.getMessage();
		}
		return null;
	}

	protected void onPostExecute(Void v) {
		if (result != null) {
			act.set_authtext(result);
		} else if (error != null) {
			Toast.makeText(act,
				"failed to load authorized_keys: " + error, 
				Toast.LENGTH_LONG).show();
		}
	}
}
