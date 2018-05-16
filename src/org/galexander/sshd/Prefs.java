package org.galexander.sshd;

import android.content.SharedPreferences;
import android.content.Context;
import android.preference.PreferenceManager;

public class Prefs {
	private static SharedPreferences pref = null;

	public static void init(Context c) {
		if (pref == null) {
			pref = PreferenceManager.getDefaultSharedPreferences(c);
		}
	}

	public static boolean get_onboot() {
		return pref.getBoolean("onboot", false);
	}
	public static boolean get_foreground() {
		return pref.getBoolean("foreground", true);
	}
	public static boolean get_onopen() {
		return pref.getBoolean("onopen", false);
	}
	public static boolean get_rsyncbuffer() {
		return pref.getBoolean("rsyncbuffer", false);
	}
	public static int get_port() {
		int ret;
		try {
			ret = Integer.valueOf(pref.getString("port", "2222"));
		} catch (Exception e) {
			ret = 2222;
		}
		return ret;
	}
	public static String get_path() {
		return pref.getString("path", "/sdcard/ssh");
	}
	public static String get_shell() {
		return pref.getString("shell", "/system/bin/sh");
	}
	public static String get_home() {
		return pref.getString("home", "/sdcard/ssh");
	}
	public static String get_extra() {
		return pref.getString("extra", "");
	}
	public static String get_env() {
		return pref.getString("env", "");
	}

	public static SharedPreferences.Editor edit() {
		return pref.edit();
	}
};
