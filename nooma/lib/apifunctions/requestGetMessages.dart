import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nooma/functions/showDialogSingleButton.dart';
import 'dart:convert' show json, utf8;
import 'package:nooma/globals.dart' as globals;

import 'package:nooma/models/MessageModel.dart';
import 'dart:convert' show utf8;

Future<List<MessageModel>> requestGetMessages(String channelID) async {
  final url = "${globals.ipAddress}/channelMessages/" +channelID;

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json;charset=UTF-8',
    'Accept': 'application/json',
  };

  final response = await http.get(
    url,
    headers: requestHeaders,
  );

  if (response.statusCode == 200) {
    final parsed = json.decode(utf8.decode(response.bodyBytes)).cast<Map<String, dynamic>>();

    return parsed.map<MessageModel>((json) => MessageModel.fromJson(json)).toList();
  } else {
    final responseJson = json.decode(response.body);
    //showDialogSingleButton(context, "Unable to get Channels", "Something has gone wrong!", "OK");
    return null;
  }
}