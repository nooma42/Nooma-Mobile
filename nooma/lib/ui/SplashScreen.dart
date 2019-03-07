import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nooma/ui/LoginPage.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {

  void goToLogin()
  {
    print("im fired!");
    Navigator.of(context).pushNamed("/LoginPage");
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),goToLogin);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
        tag: 'logo1',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius:98.0,
          child: Image.asset('assets/logo.png'),
        )
    );


    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent[49],
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo
          ],
        ),
      ),
    );
  }
}
