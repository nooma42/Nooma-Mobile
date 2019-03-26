import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nooma/apifunctions/requestGetChannels.dart';
import 'package:nooma/apifunctions/requestGetMessages.dart';
import 'package:nooma/apifunctions/requestSendMessage.dart';
import 'package:nooma/functions/ListViewChannels.dart';
import 'package:nooma/functions/ListViewMessages.dart';
import 'package:nooma/models/ChannelModel.dart';
import 'package:nooma/models/RoomModel.dart';
import 'package:nooma/models/MessageModel.dart';
import 'package:nooma/globals.dart' as globals;
import 'package:nooma/models/SendMessageModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';

class RoomPage extends StatefulWidget {
  final RoomModel room;
  final List<MessageModel> messags;

  RoomPage(this.room, this.messags);

  @override
  _RoomPageState createState() => _RoomPageState(room);
}

class _RoomPageState extends State<RoomPage> {
  var selectedIndex = 0;

  RoomModel room;
  TabController tabController;
  var appBarTitleText = new Text("");
  Future<List<ChannelModel>> channels;
  List<ChannelModel> channelsCache = new List<ChannelModel>();

  SocketIO socket;
  SocketIOManager manager;

  Future<List<MessageModel>> messages;
  List<MessageModel> msgCache = new List<MessageModel>();

  bool isProbablyConnected = false;

  ScrollController _scrollController = new ScrollController();

  SharedPreferences prefs;

  String userID;

  TextEditingController _messageController = new TextEditingController();

  ChannelModel currentChannel;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool isSocketConnected = false;

  var showDateIndex = 0;

  _RoomPageState(this.room);

  _connectSocket() async {
    //update your domain before using
    /*socketIO = new SocketIO("http://127.0.0.1:3000", "/chat",
        query: "userId=21031", socketStatusCallback: _socketStatus);*/

    socket = await manager.createInstance("http://${globals.ipAddress}",
        query: {
          "auth": "--SOME AUTH STRING---",
          "info": "new connection from adhara-socketio",
          "timestamp": DateTime.now().toString()
        },
        //Enable or disable platform channel logging
        enableLogging: false);

    socket.onConnect((data) {
      setState(() => isSocketConnected = true);
      print("connected...");
      print(data);
      connectChannel(currentChannel.channelID);
    });

    socket.onDisconnect((data) {
      setState(() => isSocketConnected = false);
    });

    socket.on("chat", (data) {
      print("recieved chat!");
      _onReceiveChatMessage(data);
    });
    socket.connect();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(_onLayoutDone);
    super.initState();
    readLocal();

    channels = requestGetChannels(context, room.roomID);
    channels.then((chnls) {
      channelsCache = chnls;
      currentChannel = chnls[0];
      setState(() {
        appBarTitleText = Text(currentChannel.channelName);
      });
      manager = SocketIOManager();
      _connectSocket();
      getMessages();
    });
  }

  @override
  void dispose() {
    manager.clearInstance(socket);
    super.dispose();
  }

  getMessages() {
    messages = requestGetMessages(currentChannel.channelID);
    messages.then((msgs) {
      setState(() {
        msgCache = msgs;
      });
    });
  }

  _onTapItem(BuildContext context, ChannelModel selectedChannel) {
    currentChannel = selectedChannel;
    msgCache = new List<MessageModel>();
    getMessages();
    setState(() {
      appBarTitleText = Text(currentChannel.channelName);
    });
    //_connectSocket();
    connectChannel(currentChannel.channelID);
    Navigator.pop(context);
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
        key: _scaffoldKey,
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
                  ? Container(
                      color: Color(0xff2A2237),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 10),
                              child: Text(
                                "Chat Channels",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              child: RefreshIndicator(
                                onRefresh: _handleRefresh,
                                child: ListView.builder(
                                    itemCount: channelsCache.length,
                                    padding: const EdgeInsets.all(15.0),
                                    itemBuilder: (context, position) {
                                      return Column(
                                        children: <Widget>[
                                          Divider(height: 5.0),
                                          ListTile(
                                            leading: Icon(
                                              Icons.message,
                                              color: currentChannel ==
                                                      channelsCache[position]
                                                  ? Colors.purple[200]
                                                  : Colors.white,
                                            ),
                                            title: Text(
                                              '${channelsCache[position].channelName}',
                                              style: new TextStyle(
                                                fontSize: 20.0,
                                                color: currentChannel ==
                                                        channelsCache[position]
                                                    ? Colors.purple[200]
                                                    : Colors.white,
                                              ),
                                            ),
                                            onTap: () => _onTapItem(context,
                                                channelsCache[position]),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          ])) // return the ListView widget
                  : Container(
                      color: Color(0xff2A2237),
                      child: Center(child: CircularProgressIndicator()));
            },
          ),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: Container(
                  color: Color(0xff2A2237),
                  child: Column(
                    children: <Widget>[
                      isSocketConnected
                          ? SizedBox()
                          : SizedBox(
                              width: double.infinity,
                              child: Container(
                                  color: Colors.redAccent,
                                  child: Center(
                                      child: Text(
                                    "Connecting...",
                                    style: TextStyle(color: Colors.white),
                                  ))),
                            ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: msgCache.length,
                          controller: _scrollController,
                          reverse: true,
                          padding: const EdgeInsets.all(15.0),
                          itemBuilder: (context, position) =>
                              buildMessage(position, msgCache[position]),
                        ),
                      ),
                    ],
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
                          controller: _messageController,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                          decoration: InputDecoration.collapsed(
                            hintText: 'Type your message...',
                            hintStyle:
                                TextStyle(fontSize: 16, color: Colors.white),
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
                          String msgContents = _messageController.text;

                          if (msgContents.isEmpty) return;

                          _messageController.text = "";
                          DateTime now = DateTime.now();
                          String formattedDate =
                              DateFormat('dd/MM/yy kk:mm:ss').format(now);
                          print("***** " + userID);
                          SendMessageModel sendMsg = SendMessageModel(
                              userID,
                              currentChannel.channelID,
                              msgContents,
                              formattedDate);
                          print(sendMsg.userID);
                          requestSendMessage(sendMsg);
                        },
                        color: Colors.white,
                      ),
                    ),
                    color: Color(0xff1c2329),
                  ),
                ],
              ),
              width: double.infinity,
              height: 50.0,
              decoration: new BoxDecoration(
                  border: new Border(
                      top: new BorderSide(color: Colors.white70, width: 0.1)),
                  color: Color(0xff1c2329)),
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
    print(message);
    MessageModel newMsg = MessageModel.fromJson(message);

    print(newMsg.messageContent);
    msgCache.insert(0, newMsg);
    setState(() {});
    _scrollController.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 1000),
    );
  }

  buildMessage(int position, MessageModel msg) {
    if (userID == msg.userID) {
      return Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Divider(height: 5.0),
              GestureDetector(
                onTap: () {
                 setState(() {
                   if(showDateIndex == position)
                     showDateIndex = -1;
                   else
                    showDateIndex = position;
                 });
                },
                child: Container(
                  width: 300.0,
                  padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  margin: EdgeInsets.only(bottom: 20.0, right: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.purple[300],
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    '${msg.messageContent}',
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          showDateIndex == position
              ? Padding( child: Text(
                  msg.sendDate,
                  style: TextStyle(color: Colors.white),
                ), padding: EdgeInsets.only(bottom: 15))
              : Container()
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          Divider(height: 5.0),
          Container(
            width: 300,
            padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
            margin: EdgeInsets.only(bottom: 20.0, right: 10.0),
            decoration: BoxDecoration(
                color: Colors.deepPurple[400],
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

  void connectChannel(String channelID) {
    if (socket != null) {
      print("connecting to channel...");
      socket.emit("channel", [
        {"channelID": "$channelID"}
      ]);
    }
  }

  void _onLayoutDone(Duration timeStamp) {
    _scaffoldKey.currentState.openDrawer();
  }

  Future<Null> _handleRefresh() async {
    requestGetChannels(context, room.roomID).then((onValue) {
      setState(() {
        channelsCache = onValue;
      });
      return null;
    });
  }
}
