import 'package:flutter/material.dart';
import 'package:nooma/models/MessageModel.dart';

class ListViewMessages extends StatelessWidget {
  final List<MessageModel> messages;

  ListViewMessages({this.messages}) : super();

  @override
  Widget build(BuildContext context) {
    return  Container(
      color: Color(0xff2A2237),
    );
  }

  void _onTapItem(BuildContext context, MessageModel msg) {
  }
}