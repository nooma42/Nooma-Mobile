import 'package:flutter/material.dart';
import 'package:nooma/ui/RegisterPage.dart';
import 'ui/LoginPage.dart';
import 'ui/SplashScreen.dart';
import 'ui/HomePage.dart';
import 'ui/RoomPage.dart';
import 'package:flutter/services.dart';

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

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.purpleAccent[900], 
    ));

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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