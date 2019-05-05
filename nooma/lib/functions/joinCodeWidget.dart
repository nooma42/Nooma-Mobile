import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:nooma/apifunctions/requestJoinRoom.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JoinCodeWidget extends StatelessWidget {

  final TextEditingController controller;

  const JoinCodeWidget(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      controller: controller,
      autovalidate: false,
      validator: (value) {
        if (value.length != 8) {
          return null;
          //return ('Invalid Join Code');
        }
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Join Code',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          suffixIcon: IconButton(
            icon: Icon(Icons.photo_camera),
            onPressed: () {
              //add camera here
              openQRScanner(context, controller);
            },
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0))),
    );

  }
}


  Future openQRScanner(context, controller) async {
    try {
      String barcode = await BarcodeScanner.scan();
      controller.text = barcode;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var userID = preferences.getString('userID');
      requestJoinRoom(context, userID, barcode);
    } catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
      } else {
      }
    }
  }