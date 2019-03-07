import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nooma/functions/saveLogin.dart';
import 'package:nooma/functions/showDialogSingleButton.dart';
import 'dart:convert';
import 'package:nooma/globals.dart' as globals;

import 'package:nooma/models/JoinRoomModel.dart';

Future<JoinRoomModel> requestAuthenticate(BuildContext context, String userID, String joinCode) async {
  final url = "http://${globals.ipAddress}/joinRoom";

  Map<String, String> body = {
    'userID': userID,
    'joinCode': joinCode,
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

    //saveLogin(responseJson);

    return JoinRoomModel.fromJson(responseJson);
  } else {
    final responseJson = json.decode(response.body);

    saveLogin(responseJson);
    showDialogSingleButton(context, "Unable to Join Room", "You may have supplied an invalid Join Code. Please try again.", "OK");
    return null;
  }
}