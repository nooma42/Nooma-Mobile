import 'package:flutter/material.dart';
import 'package:nooma/apifunctions/requestGetRooms.dart';
import 'package:nooma/apifunctions/requestJoinRoom.dart';
import 'package:nooma/functions/ListViewRooms.dart';
import 'package:nooma/functions/joinCodeWidget.dart';
import 'package:nooma/models/RoomModel.dart';
import 'package:nooma/globals.dart' as globals;

class PlaceholderWidget extends StatefulWidget {
  PlaceholderWidget();

  @override
  _PlaceholderWidgetState createState() => _PlaceholderWidgetState();
}

class _PlaceholderWidgetState extends State<PlaceholderWidget> {
  final _joinCodeController = TextEditingController();

  String userID;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    userID = getUserID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Container(
            decoration: new BoxDecoration(
                color: Colors.deepPurple[400],
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 20.0, // has the effect of softening the shadow
                  spreadRadius: 10.0, // has the effect of extending the shadow
                  offset: Offset(
                    10.0, // horizontal, move right 10
                    100.0, // vertical, move down 10
                  ),
                )
              ]),

            height: 150.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
                  child: JoinCodeWidget(_joinCodeController),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    height: 45,
                    width: 210,
                    child: RaisedButton(
                      elevation: 1.0,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0)),
                      child:
                          Text('Join Room', style: TextStyle(color: Colors.black,letterSpacing: 0.3, fontSize: 16)),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          joinRoom(_joinCodeController);
                        }
                      },
                      color: Colors.tealAccent[200],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        FutureBuilder<List<RoomModel>>(
          future: requestGetRooms(context, userID),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListViewRooms(
                    rooms: snapshot.data) // return the ListView widget
                : Expanded(
                child: Container(
                color: Color(0xff2A2237),
            child:Center(child: CircularProgressIndicator(backgroundColor: Colors.purple,))));
          },
        ),
      ],
    )));
  }

  void joinRoom(_joinCodeController) async {
    print(_joinCodeController.text);
    requestJoinRoom(context, userID, _joinCodeController.text);
  }

  String getUserID() {
    var userID = globals.userID;
    return userID;
  }
}
