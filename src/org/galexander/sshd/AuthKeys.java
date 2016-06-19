package org.galexander.sshd;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.text.InputType;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Messenger;
import android.view.View;
import android.widget.EditText;
import android.widget.Toast;

public class AuthKeys extends Activity {
	private EditText authtext;
	private String authtext_orig;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.authkeys);
		authtext = (EditText)findViewById(R.id.authtext);
		authtext_orig = null;
	}

	public void onResume() {
		super.onResume();
		AuthKeysLoad.go(this);
	}

	public void onPause() {
		save_authtext();
		super.onPause();
	}

	public void fetch_clicked(View v) {
		AlertDialog.Builder ab = new AlertDialog.Builder(this);
		ab.setTitle("Fetch authorized_keys");
		final EditText url = new EditText(this);
		url.setInputType(InputType.TYPE_CLASS_TEXT |
				 InputType.TYPE_TEXT_VARIATION_URI);
		ab.setView(url);
		ab.setPositiveButton("OK",
			new DialogInterface.OnClickListener() {
			public void onClick(DialogInterface d, int which) {
				start_fetch(url.getText().toString());
			} });
		ab.setNegativeButton("Cancel",
			new DialogInterface.OnClickListener() {
			public void onClick(DialogInterface d, int which) {
				d.cancel();
			} });
		ab.show();
	}

	public void cancel_clicked(View v) {
		authtext_orig = null;
		finish();
	}

	public void save_clicked(View v) {
		save_authtext();
		finish();
	}

	private void save_authtext() {
		String s = get_authtext();
		if ((s != null) && ((authtext_orig != null) ||
		                    !s.equals(authtext_orig))) {
			Intent i = new Intent(this, AuthKeysSave.class);
			i.putExtra("s", s);
			startService(i);
		}
		/* so that we won't save it again */
		authtext_orig = null;
	}

	private String get_authtext() {
		if (authtext != null) {
			return authtext.getText().toString();
		}
		return null;
	}

	/* called from AuthKeysLoad, which puts it on the UI thread */
	public void set_authtext(String s) {
		if (authtext != null) {
			authtext.setText(s);
			authtext_orig = s;
		}
	}

	/* called from AuthKeysFetch, from its own thread */
	public void append_authtext(String s) {
		if (authtext != null) {
			String t = get_authtext();
			if (t == null) {
				t = "";
			}
			if (!t.endsWith("\n")) {
				t += "\n";
			}
			t += s;
			authtext.setText(t);
		}
	}

	private void start_fetch(String url) {
		Intent i = new Intent(this, AuthKeysFetch.class);
		final Context ctx = this;
		i.putExtra("url", url);
		i.putExtra("m", new Messenger(new Handler() {
			public void handleMessage(Message msg) {
				Object o = msg.obj;
				if (o == null) {
					return;
				}
				String s = (String)o;
				int n = msg.arg1;
				if (n == 0) {
					/* s is data read from the url */
					append_authtext(s);
				} else {
					/* s must be an error message */
					Toast.makeText(ctx, s,
						Toast.LENGTH_LONG).show();
				}
			} } ));
		startService(i);
	}
}
