package com.salton123.fluttermusic;

import android.Manifest;
import android.annotation.TargetApi;
import android.content.Context;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Process;
import android.widget.Toast;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        if (!isPermissionGrant(this)) {
            if (Build.VERSION.SDK_INT >= 23) {
                requestPermissions(permissions, REQUEST_CODE);
            }
        }
    }

    private int REQUEST_CODE = 0x101;
    private String[] permissions = getPermissionArr();

    public String[] getPermissionArr() {
        return new String[]{
                Manifest.permission.WRITE_EXTERNAL_STORAGE
        };
    }

    @TargetApi(Build.VERSION_CODES.BASE_1_1)
    private boolean isPermissionGrant(Context context) {
        boolean result = false;
        for (String item : permissions) {
            result &= context.checkPermission(item, Process.myPid(),
                    Process.myUid()) == PackageManager.PERMISSION_GRANTED;
        }
        return result;
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == this.REQUEST_CODE) {
            if (grantResults[0] != PackageManager.PERMISSION_GRANTED) {
                Toast.makeText(getApplicationContext(),
                        "请授予全部权限",
                        Toast.LENGTH_LONG).show();
                finish();
            }
        }
    }
}
