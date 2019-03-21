import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nooma/functions/showDialogSingleButton.dart';
import 'dart:convert';
import 'package:nooma/globals.dart' as globals;

import 'package:nooma/models/MessageModel.dart';
import 'package:nooma/models/SendMessageModel.dart';

void requestSendMessage(SendMessageModel sendMsg) async {
  final url = "http://${globals.ipAddress}/channelMessages/" + sendMsg.channelID;

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, dynamic> body = sendMsg.toJson();

  final response = await http.post(
    url,
    body: json.encode(body),
    headers: requestHeaders,
  ).timeout(const Duration(seconds: 7));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<MessageModel>((json) => MessageModel.fromJson(json)).toList();
  } else {
    final responseJson = json.decode(response.body);
    //showDialogSingleButton(context, "Unable to get Channels", "Something has gone wrong!", "OK");
    return null;
  }
}