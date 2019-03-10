import 'package:flutter/material.dart';
import 'package:nooma/ui/RegisterPage.dart';
import 'ui/LoginPage.dart';
import 'ui/SplashScreen.dart';
import 'ui/HomePage.dart';
import 'ui/RoomPage.dart';

var routes = <String, WidgetBuilder>{
  "/Splash": (BuildContext context) => SplashScreen(),
  "/LoginPage": (BuildContext context) => LoginPage(),
  "/HomePage": (BuildContext context) => HomePage(),
  "/RegisterPage": (BuildContext context) => RegisterPage(),
};
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nooma',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        fontFamily: 'Roboto',
      ),
      home: SplashScreen(),
      routes: routes,
    );
  }
}