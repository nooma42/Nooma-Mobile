import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  final Color color;

  PlaceholderWidget(this.color);

  final joinCode = TextFormField(
    autofocus: false,
    decoration: InputDecoration(
        hintText: 'Join Code',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0))),
  );

  final joinCodeContainer = Container(
    color: Colors.deepPurpleAccent,
    height: 130.0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Quick Join',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(100, 10, 100, 0),
          child: TextFormField(
            autofocus: false,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Join Code',
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                suffixIcon: IconButton(
                  icon: Icon(Icons.photo_camera),
                  onPressed: () {
                    //add camera here
                    //openQRScanner();
                  },
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.0))),
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: joinCodeContainer));
  }
}
