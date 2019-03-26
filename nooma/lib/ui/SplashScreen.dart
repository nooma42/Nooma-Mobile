import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nooma/ui/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nooma/globals.dart' as globals;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {


  Future<bool> checkPreferences() async {
    //if preferences are set, take user to home and not login; they are already logged in
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var username = await prefs.get('username');
    var userID = await prefs.get('userID');
    var email = await prefs.get('email');
    var name = await prefs.get('name');

    //print(username + " - " + userID);

    if(userID != null && userID.length > 0)
      {
        if (username != null && username.length > 0)
        {
          globals.userID = userID;
          globals.username = username;
          globals.email = email;
          globals.name = name;

          return true;
        }
      }
      return false;
  }
  void goToLogin()
  {
    checkPreferences().then((hasPrefs){
      print("has prefs: " + hasPrefs.toString());
      if (!hasPrefs)
        Navigator.of(context).pushReplacementNamed('/LoginPage');
      else
        Navigator.of(context).pushReplacementNamed('/HomePage');
    });
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
    Timer(Duration(seconds: 3),goToLogin);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
        tag: 'logo1',
          child: Image.asset('assets/logo.png'),
    );

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[49],
      body:  Container(
        decoration: BoxDecoration(
        color: Color(0xff1E1D23),
    ),
    child: Center(
        child:ScrollConfiguration(
    behavior:overscrollDisable(),
    child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo
          ],
        ),
      ),
    )));
  }
}
