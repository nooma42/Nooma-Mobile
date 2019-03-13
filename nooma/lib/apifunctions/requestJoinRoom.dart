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
import 'package:nooma/ui/RoomPage.dart';

Future<JoinRoomModel> requestJoinRoom(
    BuildContext context, String userID, String joinCode) async {
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
    print(responseJson);
    //saveLogin(responseJson);


    final status = JoinRoomModel.fromJson(responseJson[0]).status;
    print(status);

    if (status == "Invalid Join Code") {
      showDialogSingleButton(
          context,
          "Unable to Join Room",
          "You may have supplied an invalid Join Code. Please try again.",
          "OK");
    } else if (status == "Success") {
      Fluttertoast.showToast(
          msg: "Room Joined Successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
      RoomModel room = RoomModel.fromJson(responseJson[0]);

      Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) => new RoomPage(room,null),
      ));
    } else if (status == "Already Joined") {
      Fluttertoast.showToast(
          msg: "Room Already Joined! Opening Room...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 2,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.white,
          fontSize: 16.0
      );
      RoomModel room = RoomModel.fromJson(responseJson[0]);

      Navigator.push(context, new MaterialPageRoute(
        builder: (BuildContext context) => new RoomPage(room, null),
      ));
    }

    return null;
  } else {
    final responseJson = json.decode(response.body);

    saveLogin(responseJson);
    showDialogSingleButton(context, "Unable to Join Room",
        "You may have supplied an invalid Join Code. Please try again.", "OK");
    return null;
  }
}
