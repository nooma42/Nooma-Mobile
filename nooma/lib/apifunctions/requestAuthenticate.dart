import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nooma/functions/saveLogin.dart';
import 'package:nooma/functions/showDialogSingleButton.dart';
import 'dart:convert';
import 'package:nooma/globals.dart' as globals;

import 'package:nooma/models/loginModel.dart';

Future<LoginModel> requestAuthenticate(BuildContext context, String email, String password) async {
  final url = "${globals.ipAddress}/authenticate";
  Map<String, String> body = {
    'email': email,
    'pwd': password,
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
      if (response.body == "Error")
        {
          showDialogSingleButton(context, "Unable to Login",
              "You may have supplied an invalid 'Email' / 'Password' combination. Please try again.",
              "OK");
          return null;
        }

      final responseJson = json.decode(response.body);
      print(response.body);
      saveLogin(responseJson).then((onValue){
        Navigator.of(context).pushReplacementNamed('/HomePage');
        return null;
      });


      return LoginModel.fromJson(responseJson);
    } else {
      print("failed! :(");
      final responseJson = json.decode(response.body);

      saveLogin(responseJson);
      showDialogSingleButton(context, "Unable to Login",
          "You may have supplied an invalid 'Email' / 'Password' combination. Please try again.",
          "OK");
      return null;
    }
  }
  on TimeoutException catch (_) {
    showDialogSingleButton(context, "Unable to Connect",
        "Connection to the server could not be made. Please try again.",
        "OK");
  }
  catch (e) {
    showDialogSingleButton(context, "Unable to Connect",
        "Connection to the server could not be made. Please try again." + e.toString(),
        "OK");
  }
}