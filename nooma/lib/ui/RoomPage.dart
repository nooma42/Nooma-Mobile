import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nooma/apifunctions/requestGetChannels.dart';
import 'package:nooma/functions/ListViewChannels.dart';
import 'package:nooma/functions/ListViewMessages.dart';
import 'package:nooma/functions/messageInput.dart';
import 'package:nooma/models/ChannelModel.dart';
import 'package:nooma/models/RoomModel.dart';
import  'package:flutter_socket_io/flutter_socket_io.dart';

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
  Future<List<ChannelModel>> channels;

  _RoomPageState(this.room);

  @override
  void initState() {
    super.initState();
    channels = requestGetChannels(room.roomID);
    channels.then((channels)
    {
    setState(() {
      appBarTitleText = Text(channels[0].channelName);
    });
    });
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
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          title: appBarTitleText,
        ),
        drawer: Drawer(
          child: FutureBuilder<List<ChannelModel>>(
            future: channels,
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
          children: <Widget>[
            buildListMessage(),
            chatInput(),

          ],
        ),
      ),
    );
  }
}
