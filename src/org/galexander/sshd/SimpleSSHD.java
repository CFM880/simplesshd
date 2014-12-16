package org.galexander.sshd;

import android.app.Activity;
import android.os.Bundle;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.Intent;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Button;
import android.view.View;

public class SimpleSSHD extends Activity
{
	private CheckBox onboot_view;
	private EditText port_view, path_view, shell_view, home_view;
	private Button startstop_view;

	public void onCreate(Bundle savedInstanceState)
	{
		super.onCreate(savedInstanceState);
		Prefs.init(this);
		setContentView(R.layout.main);
		onboot_view = (CheckBox)findViewById(R.id.onboot);
		port_view = (EditText)findViewById(R.id.port);
		path_view = (EditText)findViewById(R.id.path);
		shell_view = (EditText)findViewById(R.id.shell);
		home_view = (EditText)findViewById(R.id.home);
		startstop_view = (Button)findViewById(R.id.startstop);
	}

	public void onResume() {
		super.onResume();
		load_prefs();
		update_startstop();
		SimpleSSHDService.activity = this;
	}

	public void onPause() {
		SimpleSSHDService.activity = null;
		save_prefs();
		super.onPause();
	}

	public void update_startstop() {
		if (SimpleSSHDService.is_started()) {
			startstop_view.setText("STOP");
			startstop_view.setTextColor(0xFF881111);
		} else {
			startstop_view.setText("START");
			startstop_view.setTextColor(0xFF118811);
		}
	}

	public void startstop_clicked(View v) {
		save_prefs();
		Intent i = new Intent(this, SimpleSSHDService.class);
		if (SimpleSSHDService.is_started()) {
			i.putExtra("stop", true);
		}
		startService(i);
	}

	private void load_prefs() {
		onboot_view.setChecked(Prefs.get_onboot());
		port_view.setText(Integer.toString(Prefs.get_port()));
		path_view.setText(Prefs.get_path());
		shell_view.setText(Prefs.get_shell());
		home_view.setText(Prefs.get_home());
	}

	private void save_prefs() {
		SharedPreferences.Editor edit = Prefs.edit();
		boolean b = onboot_view.isChecked();
		if (b != Prefs.get_onboot()) { edit.putBoolean("onboot", b); }
		int i;
		try {
			i = Integer.valueOf(port_view.getText().toString());
		} catch (Exception e) {
			i = 0;
		}
		if (i != Prefs.get_port()) { edit.putInt("port", i); }
		String s = path_view.getText().toString();
		if (!s.equals(Prefs.get_path())) { edit.putString("path", s); }
		s = shell_view.getText().toString();
		if (!s.equals(Prefs.get_shell())) { edit.putString("shell", s); }
		s = home_view.getText().toString();
		if (!s.equals(Prefs.get_home())) { edit.putString("home", s); }
		edit.commit();
	}

}
