import 'package:flutter/material.dart';

Widget buildListMessage() {
  return Flexible(
    child: ListView.builder(
            padding: EdgeInsets.all(10.0),
            itemCount: 0,
            reverse: true, itemBuilder: (BuildContext context, int index) {},
          ),
  );
}