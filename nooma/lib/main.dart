import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'SplashScreen.dart';

var routes = <String, WidgetBuilder>{
  "/login": (BuildContext context) => LoginPage(),
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