import 'package:flutter/material.dart';
import 'package:nooma/apifunctions/requestGetRooms.dart';
import 'package:nooma/models/RoomModel.dart';
import 'package:nooma/ui/RoomPage.dart';
import 'package:nooma/globals.dart' as globals;

class ListViewRooms extends StatefulWidget {
  List<RoomModel> rooms;

  ListViewRooms({Key key, this.rooms}) : super(key: key);

  @override
  _ListViewRoomsState createState() => _ListViewRoomsState();
}

class _ListViewRoomsState extends State<ListViewRooms> {


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color(0xff2A2237),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Previous Rooms",
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
                  itemCount: widget.rooms.length,
                  padding: const EdgeInsets.all(15.0),
                  itemBuilder: (context, position) {
                    return Column(
                      children: <Widget>[
                        Divider(height: 5.0),
                        ListTile(
                          leading: const Icon(Icons.group,
                              size: 50, color: Colors.white),
                          title: Text(
                            '${widget.rooms[position].roomName}',
                            style: new TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            'Host: ${widget.rooms[position].host}',
                            style: new TextStyle(
                              fontSize: 13.0,
                              fontStyle: FontStyle.italic,
                              color: Colors.white70,
                            ),
                          ),
                          trailing: Text(
                            '${widget.rooms[position].eventDate}',
                            style: new TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () => _onTapItem(context, widget.rooms[position]),
                        ),
                      ],
                    );
                  }),
            )),
          ],
        ),
      ),
    );
  }

  void _onTapItem(BuildContext context, RoomModel room) {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new RoomPage(room, null),
        ));
  }

  Future<Null> _handleRefresh() async {

    requestGetRooms(null, globals.userID).then((onValue) {
      setState(() {
        widget.rooms = onValue;
      });

      return null;
    });
  }
}
