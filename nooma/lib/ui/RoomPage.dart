import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nooma/apifunctions/requestGetChannels.dart';
import 'package:nooma/functions/ListViewChannels.dart';
import 'package:nooma/models/ChannelModel.dart';
import 'package:nooma/models/RoomModel.dart';

class RoomPage extends StatefulWidget {
  final RoomModel room;

  RoomPage(this.room);

  @override
  _RoomPageState createState() => _RoomPageState(room);
}

class _RoomPageState extends State<RoomPage> {
  RoomModel room;
  TabController tabController;
  var appBarTitleText = new Text("Channel");

  _RoomPageState(RoomModel room);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RoomModel room = widget.room;
    String roomName = room.roomName;
    String roomID = room.roomID;

    String appTitle;

    return Scaffold(
      appBar: AppBar(
        title: Text('$roomName'),
      ),
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: appBarTitleText,
        ),
        drawer: Drawer(
          child: FutureBuilder<List<ChannelModel>>(
            future: requestGetChannels(context, room.roomID),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListViewChannels(
                      channels: snapshot.data) // return the ListView widget
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
        body: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}
