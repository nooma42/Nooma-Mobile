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
      decoration: InputDecoration(
          hintText: 'Confirm Password',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
    );

    final createButton = Material(
      borderRadius: BorderRadius.circular(30.0),
      shadowColor: Colors.lightBlueAccent,
      child: MaterialButton(
        elevation: 1.0,
        minWidth: double.infinity,
        height: 42.0,
        child: Text('Create Account', style: TextStyle(color: Colors.white)),
        onPressed: () {
          submit();
        },
        color: Colors.blueAccent,
      ),
    );



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
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
    );
  }
}
