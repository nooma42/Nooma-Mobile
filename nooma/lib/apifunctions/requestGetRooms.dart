import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nooma/functions/saveLogin.dart';
import 'package:nooma/functions/showDialogSingleButton.dart';
import 'dart:convert';
import 'package:nooma/globals.dart' as globals;

import 'package:nooma/models/RoomModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<RoomModel>> requestGetRooms(BuildContext context, String userID) async {

  //get userID from the shared prefs to use in URL param
  SharedPreferences preferences = await SharedPreferences.getInstance();

  final url = "http://${globals.ipAddress}/studentRooms/" + globals.userID;
  print("url:  " + url);

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  try {
    final response = await http.get(
      url,
      headers: requestHeaders,
    ).timeout(const Duration(seconds: 7));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<RoomModel>((json) => RoomModel.fromJson(json)).toList();
    } else {
      showDialogSingleButton(context, "Unable to Get Room List",
          "Something has gone horribly wrong!", "OK");
      return null;
    }
  }
  catch (e) {
    showDialogSingleButton(context, "Unable to Get Room List",
        "Something has gone horribly wrong!", "OK");
    return new List<RoomModel>();
  }
}