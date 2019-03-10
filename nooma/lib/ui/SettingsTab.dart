import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  SettingsTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Container(
            color: Colors.redAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: MaterialButton(
                    height: 40.0,
                    child:
                        Text('Logout', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.pushNamed(context, "/LoginPage");
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
