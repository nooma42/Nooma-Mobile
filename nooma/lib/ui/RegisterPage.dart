import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nooma/apifunctions/requestAuthenticate.dart';
import 'package:nooma/apifunctions/requestRegister.dart';
import 'package:nooma/functions/RegisterValidator.dart';


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

  final _formKey = GlobalKey<FormState>();

  bool _isButtonDisabled = false;

  FocusNode lastNameFocusNode = new FocusNode();
  FocusNode emailFocusNode = new FocusNode();
  FocusNode passwordFocusNode = new FocusNode();
  FocusNode confirmPasswordFocusNode = new FocusNode();

  void registerHandler(String response){
    Map<String, dynamic> user = jsonDecode(response);
    print(user['userID']);
  }

  void submit(){
    print(emailController.text);
    print(pwdController.text);

    requestRegister(context, firstNameController.text, lastNameController.text, emailController.text, pwdController.text).then((onValue){
      setState(() {_isButtonDisabled = false;});
    });
  }

  InputDecoration inputStyle(String hint) {
    return InputDecoration(
        hintStyle: TextStyle(
          color: Colors.white,
          fontSize: 17,
          fontStyle: FontStyle.italic,
        ),
        hintText: hint,
        filled: true,
        fillColor: Color(0xff353242),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.white, width: 0.0,),
        ),
        border:
        OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)));
  }

  @override
  Widget build(BuildContext context) {

    final introText = Text('Hello');

    final firstName = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: firstNameController,
      autovalidate: _autoValidate,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (String value) {
        FocusScope.of(context).requestFocus(lastNameFocusNode);
      },
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      validator: RegisterValidator.validateFirstName,
      decoration: inputStyle("First Name"),
    );

    final lastName = TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      controller: lastNameController,
      focusNode: lastNameFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term){
        FocusScope.of(context).requestFocus(emailFocusNode);
      },
      autovalidate: _autoValidate,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      validator: RegisterValidator.validateLastName,
      decoration: inputStyle("Last Name"),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: emailController,
      autovalidate: _autoValidate,
      focusNode:emailFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term){
        FocusScope.of(context).requestFocus(passwordFocusNode);
      },
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      validator: RegisterValidator.validateEmail,
      decoration: inputStyle("Email"),
    );

    final password = TextFormField(
      autofocus: false,
      controller: pwdController,
      obscureText: true,
      autovalidate: _autoValidate,
      focusNode: passwordFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term){
        FocusScope.of(context).requestFocus(confirmPasswordFocusNode);
      },
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      validator: RegisterValidator.validatePassword,
      decoration: inputStyle("Password"),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      controller: pwdConfirmController,
      obscureText: true,
      autovalidate: _autoValidate,
      focusNode: confirmPasswordFocusNode,
      textInputAction: TextInputAction.done,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      validator: (value) {
        if (value != pwdController.text) {
          return ('Entered Passwords do not match');
        }
      },
      decoration: inputStyle("Confirm Password"),
    );

    final createButton = Container(height: 60, width: 400, child: RaisedButton(
        child:_isButtonDisabled ? CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)): Text('Create Account', style: TextStyle(color: Colors.white, fontSize: 16)),
      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            setState(() {_isButtonDisabled = true;});
            submit();
          }
          else
            {
              _autoValidate = true;
            }
        },
        color: _isButtonDisabled ? Colors.grey : Colors.deepPurple[400],
      ));



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Color(0xff1E1D23),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: <Widget>[
              Form( key: _formKey, child: Column(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
