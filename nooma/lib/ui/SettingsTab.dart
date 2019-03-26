import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsTab extends StatelessWidget {
  SettingsTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Container(
            color: Color(0xff2A2237),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: MaterialButton(
                    height: 50.0,
                    minWidth: 400,

                    color: Colors.red,
                    child:
                        Text('Logout', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      preferences.clear();
                      Navigator.of(context).pushReplacementNamed("/LoginPage");
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
