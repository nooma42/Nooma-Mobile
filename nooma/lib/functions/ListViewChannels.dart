import 'package:flutter/material.dart';
import 'package:nooma/models/ChannelModel.dart';
import 'package:nooma/ui/RoomPage.dart';

class ListViewChannels extends StatelessWidget {
  final List<ChannelModel> channels;

  ListViewChannels({this.channels}) : super();

  @override
  Widget build(BuildContext context) {
    
    return  Container(
        color: Color(0xff2A2237),
        child: ListView.builder(
            itemCount: channels.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(height: 5.0),
                  ListTile(
                    leading: Icon(Icons.message, color: Colors.white,),
                    title: Text('${channels[position].channelName}',style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),),
                    onTap: () => _onTapItem(context, channels[position]),
                  ),
                ],
              );
            }),
      );
  }

  void _onTapItem(BuildContext context, ChannelModel room) {
    print(room.channelID);

  }
}