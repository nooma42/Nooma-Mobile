import 'package:flutter/material.dart';
import 'package:nooma/models/MessageModel.dart';

class ListViewMessages extends StatelessWidget {
  final List<MessageModel> messages;

  ListViewMessages({this.messages}) : super();

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Color(0xff2A2237),
      child: ListView.builder(
          itemCount: messages.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, position) {
            return Column(
              children: <Widget>[
                Divider(height: 5.0),
                ListTile(
                  title: Text('${messages[position].username}',style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),),
                  subtitle: Text('${messages[position].messageContent}',style: new TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            ),),
                  onTap: () => _onTapItem(context, messages[position]),
                ),
              ],
            );
          }),
    );
  }

  void _onTapItem(BuildContext context, MessageModel msg) {
  }
}