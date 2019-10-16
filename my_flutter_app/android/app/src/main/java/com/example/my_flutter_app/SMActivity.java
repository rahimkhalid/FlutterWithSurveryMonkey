package com.example.my_flutter_app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import org.json.JSONObject;
import com.surveymonkey.surveymonkeyandroidsdk.SurveyMonkey;
import com.surveymonkey.surveymonkeyandroidsdk.SMFeedbackActivity;
import com.surveymonkey.surveymonkeyandroidsdk.SMFeedbackFragment;
import java.util.HashMap;

import io.flutter.app.FlutterActivity;

public class SMActivity extends FlutterActivity {

    SurveyMonkey s = new SurveyMonkey();

    public static final int SM_REQUEST_CODE = 0;
    // Initialize the SurveyMonkey SDK like so


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.surveymonkey);

        Intent intent = getIntent();
        String surveyHash = intent.getStringExtra("hash");
        Log.d("test",surveyHash);
        HashMap<String, String> customVariable = new HashMap<>();
        customVariable.put("os", "Android");
        JSONObject customVariableJson = new JSONObject(customVariable);

        //Here we're setting up the SurveyMonkey Intercept Dialog -- the user will be prompted to take the survey 3 days after app install.
        // Once prompted, the user will be reminded to take the survey again in 3 weeks if they decline or 3 months if they consent to take the survey.
        // The onStart method can be overloaded so that you can supply your own prompts and intervals -- for more information, see our documentation on Github.
        //s.onStart(this, "", SM_REQUEST_CODE,surveyHash);
        s.startSMFeedbackActivityForResult(this,SM_REQUEST_CODE, surveyHash);
    }

    @Override
    protected void onStart() {
        super.onStart();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent intent) {
        //This is where you consume the respondent data returned by the SurveyMonkey Mobile Feedback SDK
        //In this example, we deserialize the user's response, check to see if they gave our app 4 or 5 stars, and then provide visual prompts to the user based on their response
        super.onActivityResult(requestCode, resultCode, intent);
        Intent output = new Intent();
        if (resultCode == RESULT_OK) {

            output.putExtra("isSuccess", "COMPLETED");
        } else {
            output.putExtra("isSuccess", "INCOMPLETED");
        }
        setResult(RESULT_OK, output);
        finish();
    }


    @Override
    protected void onStop() {
        super.onStop();
    }
}
