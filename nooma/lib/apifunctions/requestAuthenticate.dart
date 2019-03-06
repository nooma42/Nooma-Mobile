import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nooma/functions/saveLogin.dart';
import 'package:nooma/functions/showDialogSingleButton.dart';
import 'dart:convert';

import 'package:nooma/models/loginModel.dart';

Future<LoginModel> requestAuthenticate(BuildContext context, String email, String password) async {
  final url = "http://10.0.2.2:9001/authenticate";

  Map<String, String> body = {
    'email': email,
    'pwd': password,
  };

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  final response = await http.post(
    url,
    body: json.encode(body),
    headers: requestHeaders,
  );

  if (response.statusCode == 200) {
    final responseJson = json.decode(response.body);

    saveLogin(responseJson);
    Navigator.of(context).pushReplacementNamed('/HomePage');

    return LoginModel.fromJson(responseJson);
  } else {
    final responseJson = json.decode(response.body);

    saveLogin(responseJson);
    showDialogSingleButton(context, "Unable to Login", "You may have supplied an invalid 'Email' / 'Password' combination. Please try again.", "OK");
    return null;
  }
}