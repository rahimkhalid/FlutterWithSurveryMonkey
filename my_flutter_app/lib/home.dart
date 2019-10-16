import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatelessWidget {
  static const platform =
      const MethodChannel('com.Rahim.myFlutterApp/surveyMonkey');
  static String sessionSurveyMonkeyHash = 'YOUR_SURVEY_HASH_HERE';

  Future _loadSurveyMonkey() async {
    try {
      await platform
          .invokeMethod('surveyMonkey', sessionSurveyMonkeyHash)
          .then((result) {
        Fluttertoast.showToast(
            msg: result,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: _loadSurveyMonkey,
          child: Text("Load SurveyMonkey"),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
