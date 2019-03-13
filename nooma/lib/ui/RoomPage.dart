import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nooma/apifunctions/requestGetChannels.dart';
import 'package:nooma/apifunctions/requestGetMessages.dart';
import 'package:nooma/functions/ListViewChannels.dart';
import 'package:nooma/functions/ListViewMessages.dart';
import 'package:nooma/models/ChannelModel.dart';
import 'package:nooma/models/RoomModel.dart';
import 'package:nooma/models/MessageModel.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:nooma/globals.dart' as globals;

class RoomPage extends StatefulWidget {
  final RoomModel room;
  final List<MessageModel> messages;

  RoomPage(this.room, this.messages);

  @override
  _RoomPageState createState() => _RoomPageState(room);
}

class _RoomPageState extends State<RoomPage> {
  RoomModel room;
  TabController tabController;
  var appBarTitleText = new Text("Channel");
  Future<List<ChannelModel>> channels;
  SocketIO socketIO;
  Future<List<MessageModel>> messages;

  _RoomPageState(this.room);

  _connectSocket(channelID) {
    //update your domain before using
    /*socketIO = new SocketIO("http://127.0.0.1:3000", "/chat",
        query: "userId=21031", socketStatusCallback: _socketStatus);*/
    socketIO = SocketIOManager().createSocketIO(
        "http://${globals.ipAddress}", "/",
        socketStatusCallback: _socketStatus);
    //call init socket before doing anything
    socketIO.init();

    //subscribe event
    //socketIO.subscribe("socket_info", _onSocketInfo);
    //socketIO.subscribe(channelID, _onReceiveChatMessage);
    socketIO.subscribe("chat", _onReceiveChatMessage);

    //socketIO.handlerMethodCall("chat", _onReceiveChatMessage, '{"messageContent": "hello"}');
    //connect socket
    socketIO.connect();

    String jsonData = '{"channelID": "$channelID"}';
    socketIO.sendMessage("channel", jsonData, _onReceiveChatMessage);
  }

  @override
  void initState() {
    super.initState();
    channels = requestGetChannels(room.roomID);
    channels.then((channels) {
      setState(() {
        appBarTitleText = Text(channels[0].channelName);
      });
      messages = requestGetMessages(channels[0].channelID);
      _connectSocket(channels[0].channelID);
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
            Flexible(
              child: FutureBuilder<List<MessageModel>>(
                future: messages,
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? ListViewMessages(
                          messages: snapshot.data) // return the ListView widget
                      : Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  // Button send image
                  // Edit text
                  Flexible(
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Type your message...',
                            hintStyle: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Button send message
                  Material(
                    child: new Container(
                      margin: new EdgeInsets.symmetric(horizontal: 8.0),
                      child: new IconButton(
                        icon: new Icon(Icons.send),
                        onPressed: () {
                          String jsonData =
                              '{"messageContent": "Hello! im a telephone :)"}';
                          socketIO.sendMessage("chat", jsonData);
                        },
                        color: Colors.black,
                      ),
                    ),
                    color: Colors.white,
                  ),
                ],
              ),
              width: double.infinity,
              height: 50.0,
              decoration: new BoxDecoration(
                  border: new Border(
                      top: new BorderSide(color: Colors.grey, width: 0.5)),
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  static _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }

  void _onReceiveChatMessage(dynamic message) {
    Map msgMap = jsonDecode(message);
    MessageModel newMsg = MessageModel.fromJson(msgMap);

    print(newMsg.messageContent);
    Fluttertoast.showToast(
        msg: newMsg.messageContent,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 2,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
