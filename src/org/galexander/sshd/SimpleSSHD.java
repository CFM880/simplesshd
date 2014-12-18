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
import android.view.Menu;
import android.view.MenuItem;
import android.net.Uri;

public class SimpleSSHD extends Activity
{
	private Button startstop_view;
	public static SimpleSSHD curr = null;

	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		Prefs.init(this);
		setContentView(R.layout.main);
		startstop_view = (Button)findViewById(R.id.startstop);
	}

	public void onResume() {
		super.onResume();
		update_startstop();
		curr = this;
	}

	public void onPause() {
		curr = null;
		super.onPause();
	}

	public boolean onCreateOptionsMenu(Menu menu) {
		getMenuInflater().inflate(R.menu.main_menu, menu);
		return true;
	}

	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
			case R.id.settings:
				startActivity(new Intent(this, Settings.class));
				return true;
			case R.id.about: {
				Intent i = new Intent(Intent.ACTION_VIEW);
				i.setData(Uri.parse("http://www.galexander.org/software/simplesshd"));
				startActivity(i);
			}	return true;
			default:
				return super.onOptionsItemSelected(item);
		}
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
		Intent i = new Intent(this, SimpleSSHDService.class);
		if (SimpleSSHDService.is_started()) {
			i.putExtra("stop", true);
		}
		startService(i);
	}
}
