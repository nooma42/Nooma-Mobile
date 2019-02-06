import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'loginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final logo = Hero(
        tag: 'logo',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/logo.png'),
        ));

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: '',
      decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: '',
      obscureText: true,
      decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent,
        child: MaterialButton(
          elevation: 1.0,
          minWidth: 200.0,
          height: 42.0,
          child: Text('Login', style: TextStyle(color: Colors.white)),
          onPressed: () {},
          color: Colors.blueAccent,
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.black45),
        textAlign: TextAlign.left,
      ),
      onPressed: () {},
    );

    final signupButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent,
        child: MaterialButton(
          elevation: 1.0,
          minWidth: 200.0,
          height: 42.0,
          child: Text('Sign Up', style: TextStyle(color: Colors.white)),
          onPressed: () {},
          color: Colors.redAccent,
        ),
      ),
    );

    final divider = SizedBox(
      height: 1.0,
      child: new Center(
        child: new Container(
          margin: new EdgeInsetsDirectional.only(start: 40.0, end: 40.0),
          height: 1.0,
          color: Colors.black87,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 10.0),
            password,
            SizedBox(height: 4.0),
            forgotLabel,
            SizedBox(height: 5.0),
            loginButton,
            SizedBox(height: 15.0),
            divider,
            SizedBox(height: 15.0),
            signupButton
          ],
        ),
      ),
    );
  }
}
