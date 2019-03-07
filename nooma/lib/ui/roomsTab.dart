import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nooma/apifunctions/requestGetRooms.dart';
import 'package:nooma/functions/joinCodeWidget.dart';
import 'package:nooma/models/RoomModel.dart';

class PlaceholderWidget extends StatefulWidget {
  PlaceholderWidget();

  @override
  _PlaceholderWidgetState createState() => _PlaceholderWidgetState();
}

class _PlaceholderWidgetState extends State<PlaceholderWidget> {

  final _joinCodeController = TextEditingController();

  @override
  void initState() {
    Future<List<RoomModel>> rooms = requestGetRooms(context, "23");
    rooms.then((vals){
      print(vals.length);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Container(
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
    )));
  }

  void joinRoom(_joinCodeController) {
    print(_joinCodeController.text);
    
  }
}



