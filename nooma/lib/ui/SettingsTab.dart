import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {

  SettingsTab();

  final joinCodeContainer = Container(
    color: Colors.redAccent,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: joinCodeContainer));
  }
}
