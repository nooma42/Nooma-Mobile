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
import 'package:shared_preferences/shared_preferences.dart';

class RoomPage extends StatefulWidget {
  final RoomModel room;
  final List<MessageModel> messags;

  RoomPage(this.room, this.messags);

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
  List<MessageModel> msgCache = new List<MessageModel>();

  ScrollController _scrollController = new ScrollController();

  SharedPreferences prefs;

  String userID;

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
    print(jsonData);
    socketIO.sendMessage("channel", jsonData, _onChannelJoin);
  }

  @override
  void initState() {
    super.initState();
    readLocal();
    channels = requestGetChannels(room.roomID);
    channels.then((channels) {
      setState(() {
        appBarTitleText = Text(channels[0].channelName);
      });
      _connectSocket(channels[0].channelID);
      messages = requestGetMessages(channels[0].channelID);
      messages.then((msgs) {
        setState(() {
          msgCache = msgs;
        });
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
            Flexible(
              child: Container(
                  color: Color(0xff2A2237),
                  child: ListView.builder(
                    itemCount: msgCache.length,
                    controller: _scrollController,
                    reverse: true,
                    padding: const EdgeInsets.all(15.0),
                    itemBuilder: (context, position) =>
                        buildMessage(position, msgCache[position]),
                  )), // return the ListView widget
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

  void _onChannelJoin(dynamic message) {
    print("*** connection:" + message + " ***");
  }

  void _onReceiveChatMessage(dynamic message) {
    Map msgMap = jsonDecode(message);
    MessageModel newMsg = MessageModel.fromJson(msgMap);

    print(newMsg.messageContent);
    msgCache.insert(0, newMsg);
    setState(() {});
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  buildMessage(int position, MessageModel msg) {
    if(userID == msg.userID) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Divider(height: 5.0),
          Container(
            width: 300.0,
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            margin: EdgeInsets.only(bottom: 20.0 , right: 10.0),
            decoration: BoxDecoration(color: Colors.purpleAccent,
                borderRadius: BorderRadius.circular(8.0)),
            child: Text(
                '${msg.messageContent}',
                style: new TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
          ),
        ],
      );
    }
    else
      {
        return Row(
          children: <Widget>[
            Divider(height: 5.0),
            Container(
              width: 300,
              padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
              margin: EdgeInsets.only(bottom: 20.0 , right: 10.0),
              decoration: BoxDecoration(color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8.0)),
              child: ListTile(
                title: Text(
                  '${msg.username}',
                  style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  '${msg.messageContent}',
                  style: new TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      }
  }

  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    userID = prefs.getString('userID') ?? '';
  }
}
