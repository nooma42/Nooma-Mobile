import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nooma/functions/showDialogSingleButton.dart';
import 'dart:convert';
import 'package:nooma/globals.dart' as globals;

import 'package:nooma/models/ChannelModel.dart';

Future<List<ChannelModel>> requestGetChannels(BuildContext context, String channelID) async {
  final url = "http://${globals.ipAddress}/channels/" +channelID;
  print(url);
  Map<String, String> body = {
  };

  Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  final response = await http.get(
    url,
    headers: requestHeaders,
  );

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<ChannelModel>((json) => ChannelModel.fromJson(json)).toList();
  } else {
    final responseJson = json.decode(response.body);
    showDialogSingleButton(context, "Unable to get Channels", "Something has gone wrong!", "OK");
    return null;
  }
}