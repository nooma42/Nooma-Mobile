import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nooma/globals.dart' as globals;
import 'package:nooma/models/JoinRoomModel.dart';

import 'package:nooma/models/MessageModel.dart';
import 'package:nooma/models/SetPasswordModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List> requestSetPassword(BuildContext context, SetPasswordModel sendModel) async {
  final url = "${globals.ipAddress}/setStudentPassword/" + sendModel.userID;

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, dynamic> body = sendModel.toJson();
  print(body);

  final response = await http.post(
    url,
    body: json.encode(body),
    headers: requestHeaders,
  ).timeout(const Duration(seconds: 7));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body);


      final responseJson = json.decode(response.body);
      print(responseJson);

      final status = JoinRoomModel
          .fromJson(responseJson[0])
          .status;
      if (status == "Success") {
        Fluttertoast.showToast(
            msg: "Password Changed Successfully! Please Login",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 2,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );

        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.clear();

        Navigator.of(context)
            .pushNamedAndRemoveUntil('/LoginPage', (Route<dynamic> route) => false);
      }
      else if (status == "passwordWrong") {
        Fluttertoast.showToast(
            msg: "Current Password Incorrect, Please try again",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 2,
            backgroundColor: Colors.deepPurpleAccent,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      return parsed;
  } else {
    final responseJson = json.decode(response.body);
    //showDialogSingleButton(context, "Unable to get Channels", "Something has gone wrong!", "OK");
    return null;
  }
}