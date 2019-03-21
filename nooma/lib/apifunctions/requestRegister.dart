import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nooma/functions/saveLogin.dart';
import 'package:nooma/functions/showDialogSingleButton.dart';
import 'dart:convert';
import 'package:nooma/globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nooma/models/JoinRoomModel.dart';
import 'package:nooma/models/RoomModel.dart';
import 'package:nooma/ui/LoginPage.dart';
import 'package:nooma/ui/RoomPage.dart';

Future<JoinRoomModel> requestRegister(BuildContext context, String firstName,
    String lastName, String email, String pwd) async {
  final url = "http://${globals.ipAddress}/users";

  Map<String, String> body = {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'pwd': pwd,
  };

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };
  try {
    final response = await http.post(
      url,
      body: json.encode(body),
      headers: requestHeaders,
    ).timeout(const Duration(seconds: 7));

    if (response.statusCode == 200) {
      final responseJson = json.decode(response.body);
      print(responseJson);

      final status = JoinRoomModel
          .fromJson(responseJson[0])
          .status;

      if (status == "Success") {
        Fluttertoast.showToast(
            msg: "  Registration Successful! Please Login  ",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 2,
            backgroundColor: Colors.white,
            textColor: Colors.black,
            fontSize: 16.0
        );
        Navigator.push(context, new MaterialPageRoute(
          builder: (BuildContext context) => new LoginPage(),
        ));
      }

      return null;
    } else {
      final responseJson = json.decode(response.body);

      saveLogin(responseJson);
      showDialogSingleButton(context, "Unable to Register",
          "Something has gone wrong when registering.", "OK");
      return null;
    }
  }
  on TimeoutException catch (_) {
    showDialogSingleButton(context, "Unable to Connect",
        "Connection to the server could not be made. Please try again.",
        "OK");
  }
  catch (e)
  {
    print(e);
    return null;
  }

}

