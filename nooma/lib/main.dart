import 'package:flutter/material.dart';
import 'ui/LoginPage.dart';
import 'ui/SplashScreen.dart';
import 'ui/HomePage.dart';

var routes = <String, WidgetBuilder>{
  "/LoginPage": (BuildContext context) => LoginPage(),
  "/HomePage": (BuildContext context) => HomePage(),
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