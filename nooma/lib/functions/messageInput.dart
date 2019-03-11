import 'package:flutter/material.dart';

Widget chatInput() {
  return Container(
    child: Row(
      children: <Widget>[
        // Button send image
        // Edit text
        Flexible(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left:10),
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
              onPressed: () {},
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
        border: new Border(top: new BorderSide(color: Colors.grey, width: 0.5)), color: Colors.white),
  );
}