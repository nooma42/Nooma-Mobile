import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nooma/apifunctions/requestAuthenticate.dart';
import 'package:nooma/apifunctions/requestRegister.dart';


class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final firstNameController = TextEditingController(text: "");
  final lastNameController = TextEditingController(text: "");
  final emailController = TextEditingController(text: "");
  final pwdController = TextEditingController(text: "");
  final pwdConfirmController = TextEditingController(text: "");

  bool _autoValidate = false;

  void registerHandler(String response){
    Map<String, dynamic> user = jsonDecode(response);
    print(user['userID']);
  }

  void submit(){
    print(emailController.text);
    print(pwdController.text);

    requestRegister(context, firstNameController.text, lastNameController.text, emailController.text, pwdController.text);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
        tag: 'logo1',
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/logo.png'),
        ));

    final firstName = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: firstNameController,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value.length == 0) {
          return ('Please enter your First Name.');
        }
      },
      decoration: InputDecoration(
          hintText: 'First Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final lastName = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: lastNameController,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value.length == 0) {
          return ('Please enter your Last Name.');
        }
      },
      decoration: InputDecoration(
          hintText: 'Last Name',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: emailController,
      autovalidate: true,
      validator: (value) {
        RegExp regExp = new RegExp(
          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
          caseSensitive: false,
          multiLine: false,
        );
        if(!regExp.hasMatch(value))
          {
            return "Please enter a valid email address.";
          }
      },
      decoration: InputDecoration(
          hintText: 'Email',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );


    final password = TextFormField(
      autofocus: false,
      controller: pwdController,
      obscureText: true,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value.length < 8) {
          return ('Your password must be at least 8 characters.');
        }
      },
      decoration: InputDecoration(
          hintText: 'Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      controller: pwdConfirmController,
      obscureText: true,
      autovalidate: _autoValidate,
      validator: (value) {
        if (value != pwdController.text) {
          return ('Entered Passwords do not match');
        }
      },
      decoration: InputDecoration(
          hintText: 'Confirm Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final createButton = Container(height: 60, child: RaisedButton(
        child: Text('Create Account', style: TextStyle(color: Colors.white, fontSize: 16)),
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        onPressed: () {
          submit();
        },
        color: Colors.deepPurple[400],
      ));



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.white, //Color(0xff1E1D23),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      firstName,
                      SizedBox(height: 15.0),
                      lastName,
                      SizedBox(height: 15.0),
                      email,
                      SizedBox(height: 15.0),
                      password,
                      SizedBox(height: 15.0),
                      confirmPassword,
                      SizedBox(height: 25.0),
                      createButton,
                    ],
                  ),
                ],
          ),
        ),
      ),
    );
  }
}
