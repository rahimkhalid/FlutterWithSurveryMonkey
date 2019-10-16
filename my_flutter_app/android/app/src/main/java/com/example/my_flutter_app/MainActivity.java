package com.example.my_flutter_app;

import android.content.Intent;
import android.os.Bundle;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "com.Rahim.myFlutterApp/surveyMonkey";
  private MethodChannel.Result result;
  private static final int REQUESTCODE = 120;


  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
            new MethodChannel.MethodCallHandler() {
              @Override
              public void onMethodCall(MethodCall call, MethodChannel.Result result) {
                startSurveyMonkeyActivity((String) call.arguments, result);
              }
            });
  }

  private void startSurveyMonkeyActivity(String sdkData, MethodChannel.Result result) {
    Intent intent = new Intent(this, SMActivity.class);
    intent.putExtra("hash", sdkData);
    this.result = result;
    startActivityForResult(intent, REQUESTCODE);
  }

  @Override
  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if (requestCode == REQUESTCODE && resultCode == RESULT_OK && data != null) {
      String resultString = data.getStringExtra("isSuccess");
      result.success(resultString);
    }
  }
}
