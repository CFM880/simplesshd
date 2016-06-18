package org.galexander.sshd;

import android.app.Activity;
import android.os.Bundle;
import android.widget.EditText;
import android.view.View;

public class AuthKeys extends Activity {
	private static final Object lock = new Object();
	private EditText authtext;
	private String authtext_str;
	private long authtext_when;	/* XXX - type for timestamp?? */
	private boolean authtext_needs_save;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.authkeys);
		authtext = (EditText)findViewById(R.id.authtext);
		authtext_str = null;
		authtext_needs_save = false;
		authtext_when = 0;
		/* XXX - disable R.id.save_auth */
	}

	/* XXX - on changes to authtext, enable R.id.save_auth, and set authtext_needs_save */

	public void onResume() {
		super.onResume();
		/* XXX - start a thread that reads /sdcard/ssh/authorized_keys, updates authtext, iff authorized_keys is newer than authtext_when. sets authtext_when to now if it read anything. otherwise sets authtext from authtext_str */
	}

	public void onPause() {
		authtext_str = authtext.getText().toString();
		/* XXX - if unsaved changes, toast notify of them */
		super.onPause();
	}

	public void fetch_clicked(View v) {
		/* XXX - dialog to ask for http...when that dialog is done,
		 * start thread that grabs the http and then appends its
		 * contents to authtext */
	}

	public void cancel_clicked(View v) {
		authtext_str = null;
		authtext_when = 0;
	}

	public void save_clicked(View v) {
		/* XXX - start thread that writes to file */
	}
}
