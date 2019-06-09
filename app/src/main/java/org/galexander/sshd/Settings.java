package org.galexander.sshd;

import android.os.Build;
import android.os.Bundle;
import android.preference.CheckBoxPreference;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.widget.Toast;

public class Settings extends PreferenceActivity {
	private CheckBoxPreference pref_onboot, pref_foreground;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		addPreferencesFromResource(R.xml.preferences);

		pref_onboot = (CheckBoxPreference)findPreference("onboot");
		pref_foreground =
			(CheckBoxPreference)findPreference("foreground");

		Preference.OnPreferenceChangeListener l = 
			new Preference.OnPreferenceChangeListener() {
				public boolean onPreferenceChange(Preference p,
					Object v_) {
					boolean v =((Boolean)v_).booleanValue();
					((CheckBoxPreference)p).setChecked(v);
					check();
					return false;
				} };
		pref_onboot.setOnPreferenceChangeListener(l);
		pref_foreground.setOnPreferenceChangeListener(l);
	}

	public void onResume() {
                super.onResume();
		check();
	}

	private void check() {
		if ((Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) &&
		    pref_onboot.isChecked() &&
		    !pref_foreground.isChecked()) {
			pref_foreground.setChecked(true);
			Toast.makeText(this,
"Android Oreo will not start a background service at boot. Forcing foreground.",
                                        Toast.LENGTH_LONG).show();
		}
	}
}
