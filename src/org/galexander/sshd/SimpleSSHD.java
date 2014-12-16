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
	}

	public void update_startstop() {
		if (SimpleSSHDService.is_started()) {
			startstop_view.setText("STOP");
			startstop_view.setTextColor(0xFFFF8888);
		} else {
			startstop_view.setText("START");
			startstop_view.setTextColor(0xFF88FF88);
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
		SharedPreferences prefs = getPreferences(Context.MODE_PRIVATE);
		onboot_view.setChecked(get_onboot(prefs));
		port_view.setText(Integer.toString(get_port(prefs)));
		path_view.setText(get_path(prefs));
		shell_view.setText(get_shell(prefs));
		home_view.setText(get_home(prefs));
	}

	private void save_prefs() {
		SharedPreferences prefs = getPreferences(Context.MODE_PRIVATE);
		SharedPreferences.Editor edit = prefs.edit();
		boolean b = onboot_view.isChecked();
		if (b != get_onboot(prefs)) { edit.putBoolean("onboot", b); }
		int i = Integer.valueOf(onboot_view.getText().toString());
		if (i != get_port(prefs)) { edit.putInt("port", i); }
		String s = path_view.getText().toString();
		if (!s.equals(get_path(prefs))) { edit.putString("path", s); }
		s = shell_view.getText().toString();
		if (!s.equals(get_shell(prefs))) { edit.putString("shell", s); }
		s = home_view.getText().toString();
		if (!s.equals(get_home(prefs))) { edit.putString("home", s); }
		edit.commit();
	}

	public static boolean get_onboot(SharedPreferences p) {
		return p.getBoolean("onboot", false);
	}
	public static int get_port(SharedPreferences p) {
		return p.getInt("port", 2222);
	}
	public static String get_path(SharedPreferences p) {
		return p.getString("path", "/sdcard/ssh");
	}
	public static String get_shell(SharedPreferences p) {
		return p.getString("shell", "/system/bin/sh -l");
	}
	public static String get_home(SharedPreferences p) {
		return p.getString("home", "/sdcard/ssh");
	}
}
