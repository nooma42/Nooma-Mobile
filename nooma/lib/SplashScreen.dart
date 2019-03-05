import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nooma/LoginPage.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {

  void goToLogin()
  {
    print("im fired!");
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void initState() {
    super.initState();
    print("im fire!");
    Timer(Duration(seconds: 3),goToLogin);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
        tag: 'logo',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius:98.0,
          child: Image.asset('assets/logo.png'),
        )
    );

    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
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
