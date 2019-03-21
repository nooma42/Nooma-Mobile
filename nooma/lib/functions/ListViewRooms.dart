import 'package:flutter/material.dart';
import 'package:nooma/models/RoomModel.dart';
import 'package:nooma/ui/RoomPage.dart';

class ListViewRooms extends StatelessWidget {
  final List<RoomModel> rooms;

  ListViewRooms({Key key, this.rooms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Color(0xff2A2237),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Previous Rooms", style: TextStyle( color: Colors.white,fontSize: 30, fontWeight: FontWeight.bold),
      ),
            ),
        Expanded(child:ListView.builder(
                itemCount: rooms.length,
                padding: const EdgeInsets.all(15.0),
                itemBuilder: (context, position) {
                  return Column(
                    children: <Widget>[
                      Divider(height: 5.0),
                      ListTile(
                        leading: const Icon(Icons.group, size:50, color:Colors.white),
                        title: Text(
                          '${rooms[position].roomName}',
                          style: new TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          'Host: ${rooms[position].host}',
                          style: new TextStyle(
                            fontSize: 13.0,
                            fontStyle: FontStyle.italic,
                            color: Colors.white70,
                          ),
                        ),
                        trailing: Text(
                          '${rooms[position].eventDate}',
                          style: new TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () => _onTapItem(context, rooms[position]),
                      ),
                    ],
                  );
                })),
          ],
        ),
      ),
    );
  }

  void _onTapItem(BuildContext context, RoomModel room) {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new RoomPage(room,null),
        ));
  }
}
