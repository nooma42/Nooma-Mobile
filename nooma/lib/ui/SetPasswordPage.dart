import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nooma/apifunctions/requestSetPassword.dart';
import 'package:nooma/functions/RegisterValidator.dart';
import 'package:nooma/models/SendMessageModel.dart';
import 'package:nooma/models/SetPasswordModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SetPasswordPage extends StatefulWidget {

  @override
  _SetPasswordPageState createState() => _SetPasswordPageState();

}

class _SetPasswordPageState extends State<SetPasswordPage> {

  final oldPwdController = TextEditingController(text: "");
  final newPwdController = TextEditingController(text: "");
  final newPwdConfirmController = TextEditingController(text: "");

  bool _autoValidate = false;

  final _formKey = GlobalKey<FormState>();

  bool _isButtonDisabled = false;

  FocusNode oldPwdFocusNode = new FocusNode();
  FocusNode newPwdFocusNode = new FocusNode();
  FocusNode newPwdConfirmNode = new FocusNode();

  SharedPreferences prefs;
  String userID;

  @override
  void initState() {
    super.initState();
    readLocal();
  }

  void submit(){

    SetPasswordModel sendModel = SetPasswordModel(
        userID,
      newPwdController.text,
      oldPwdController.text,
    );
    requestSetPassword(context, sendModel).then((onValue){
      setState(() {_isButtonDisabled = false;});
    });
  }

  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID') ?? '';
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

    final oldPassword = TextFormField(
      autofocus: false,
      controller: oldPwdController,
      obscureText: true,
      autovalidate: _autoValidate,
      focusNode: oldPwdFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term){
        FocusScope.of(context).requestFocus(newPwdFocusNode);
      },
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      validator: RegisterValidator.validatePassword,
      decoration: inputStyle("Current Password"),
    );

    final newPassword = TextFormField(
      autofocus: false,
      controller: newPwdController,
      obscureText: true,
      autovalidate: _autoValidate,
      focusNode: newPwdFocusNode,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (term){
        FocusScope.of(context).requestFocus(newPwdConfirmNode);
      },
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      validator: RegisterValidator.validatePassword,
      decoration: inputStyle("New Password"),
    );

    final confirmNewPassword = TextFormField(
      autofocus: false,
      controller: newPwdConfirmController,
      obscureText: true,
      autovalidate: _autoValidate,
      focusNode: newPwdConfirmNode,
      textInputAction: TextInputAction.done,
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      validator: (value) {
        if (value != newPwdController.text) {
          return ('Entered Passwords do not match');
        }
      },
      decoration: inputStyle("Confirm Password"),
    );

    final createButton = Container(height: 60, width: 400, child: RaisedButton(
      child:_isButtonDisabled ? CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)): Text('Change Password', style: TextStyle(color: Colors.white, fontSize: 16)),
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
        title: Text("Change Password"),
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
                  oldPassword,
                  SizedBox(height: 15.0),
                  newPassword,
                  SizedBox(height: 15.0),
                  confirmNewPassword,
                  SizedBox(height: 15.0),
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
