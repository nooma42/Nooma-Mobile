import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nooma/apifunctions/requestAuthenticate.dart';
import 'package:nooma/functions/LoginValidator.dart';
class overscrollDisable extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class LoginPage extends StatefulWidget {
  static String tag = 'loginPage';

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginData {
  String email = '';
  String pwd = '';
}

class _LoginPageState extends State<LoginPage> {
  _LoginData _data = new _LoginData();

  final emailController =
      TextEditingController(text: "");
  final pwdController = TextEditingController(text: "");

  FocusNode emailFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();

  bool _isButtonDisabled = false;

  final _formKey = GlobalKey<FormState>();

  void loginHandler(String response) {
    Map<String, dynamic> user = jsonDecode(response);
    print(user['userID']);
  }

  void submit() {
    print(emailController.text);
    print(pwdController.text);

    requestAuthenticate(context, emailController.text, pwdController.text)
        .then((onValue) {
      setState(() {
        _isButtonDisabled = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
        tag: 'logo1',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 100.0,
          child: Image.asset('assets/logo.png'),
        ));

    final email = Theme(
        data: new ThemeData(
          primaryColor: Colors.purpleAccent,
          primaryColorDark: Colors.purple,
        ),
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          controller: emailController,
          focusNode: emailFocusNode,
          validator: LoginValidator.validateEmail,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (term) {
            FocusScope.of(context).requestFocus(passwordFocusNode);
          },
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontStyle: FontStyle.italic,
              ),
              hintText: 'Email',
              filled: true,
              fillColor: Color(0xff353242),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 0.0,
                ),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0))),
        ));

    final password = Theme(
        data: new ThemeData(
          primaryColor: Colors.purpleAccent,
          primaryColorDark: Colors.purple,
        ),
        child: TextFormField(
          autofocus: false,
          focusNode: passwordFocusNode,
          textInputAction: TextInputAction.done,
          validator: LoginValidator.validatePassword,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontStyle: FontStyle.italic,
          ),
          controller: pwdController,
          obscureText: true,
          decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintStyle: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              hintText: 'Password',
              filled: true,
              fillColor: Color(0xff353242),
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 0.0,
                ),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0))),
        ));

    final loginButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 0.0),
        child: Container(
          height: 60,
          child: RaisedButton(
            elevation: 1.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            child: _isButtonDisabled
                ? CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white))
                : Text("Login",
                    style: TextStyle(color: Colors.white, fontSize: 17)),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _isButtonDisabled ? null : submit();
                setState(() {
                  _isButtonDisabled = true;
                });
              }
            },
            color: _isButtonDisabled ? Colors.grey : Colors.deepPurple[400],
          ),
        ));

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot Password?',
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.left,
      ),
      onPressed: () {},
    );

    final signupButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 0.0),
      child: Container(
        height: 60,
        child: FlatButton(
          color: Color(0xff1E1D23),
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0)),
          child: Text('Don\'t have an account? Sign Up',
              style: TextStyle(color: Colors.white, fontSize: 16)),
          onPressed: () {
            Navigator.of(context).pushNamed('/RegisterPage');
          },
        ),
      ),
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff1E1D23),
          ),
          child: Center(
            child: ScrollConfiguration(
              behavior: overscrollDisable(),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(24.0),
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
                    signupButton
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
