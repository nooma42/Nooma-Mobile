import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nooma/ui/LoginPage.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {

  void goToLogin()
  {
    Navigator.of(context).pushReplacementNamed('/LoginPage');
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
