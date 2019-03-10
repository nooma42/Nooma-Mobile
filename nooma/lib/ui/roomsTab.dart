import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nooma/apifunctions/requestGetRooms.dart';
import 'package:nooma/apifunctions/requestJoinRoom.dart';
import 'package:nooma/functions/ListViewRooms.dart';
import 'package:nooma/functions/joinCodeWidget.dart';
import 'package:nooma/models/RoomModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceholderWidget extends StatefulWidget {
  PlaceholderWidget();

  @override
  _PlaceholderWidgetState createState() => _PlaceholderWidgetState();
}

class _PlaceholderWidgetState extends State<PlaceholderWidget> {
  final _joinCodeController = TextEditingController();

  String userID;

  @override
  void initState() {
      Future<String> userId = getUserID();

      userId.then((onValue) {
        userID = onValue;
      });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
              children: <Widget>[
                Container(
      color: Colors.deepPurpleAccent,
      height: 150.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
                'Quick Join',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16,
                ),
          ),
          Padding(
                padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                child: JoinCodeWidget(_joinCodeController),
          ),
          Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: MaterialButton(
                  elevation: 1.0,
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text('Join Room', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    joinRoom(_joinCodeController);
                  },
                  color: Colors.greenAccent,
                ),
          ),

        ],
      ),
    ),
                FutureBuilder<List<RoomModel>>(
                  future: requestGetRooms(context, userID),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? ListViewRooms(
                        rooms: snapshot.data) // return the ListView widget
                        : Center( child: CircularProgressIndicator());
                  },
                ),
              ],
            )));
  }

  void joinRoom(_joinCodeController) async {
    print(_joinCodeController.text);
    requestJoinRoom(context, userID,_joinCodeController.text);
  }

  Future<String> getUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var userID = preferences.getString('userID');
    return userID;
  }
}
