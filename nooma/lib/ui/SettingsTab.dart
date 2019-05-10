import 'package:flutter/material.dart';
import 'package:nooma/ui/SetPasswordPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nooma/globals.dart' as globals;

class SettingsTab extends StatelessWidget {
  SettingsTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account Settings"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: SizedBox.expand(
          child: Container(
            color: Color(0xff2A2237),
            child: Column(
              children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text('Username',style: TextStyle(fontSize: 20, color: Colors.white70),),
                    trailing: Text('${globals.username}',style: TextStyle(color: Colors.white),),
                  ),
                  ListTile(
                    title: Text('Email',style: TextStyle(fontSize: 20, color: Colors.white70),),
                    trailing: Text('${globals.email}',style: TextStyle(color: Colors.white),),
                  ),
                  ListTile(
                    title: Text('Name', style: TextStyle(fontSize: 20, color: Colors.white70),),
                    trailing: Text('${globals.name}',style: TextStyle(color: Colors.white),),

                  ),
                 Material(
                   color: Colors.deepPurple[400],
                    child: ListTile(
                      onTap: () => changePassword(context),
                      trailing: Icon(Icons.arrow_forward_ios, color:Colors.white),
                      title: Text('Change Password', style: TextStyle(fontSize: 20, color: Colors.white),),
                    ),
                  ),
                ],
              ),
            ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: MaterialButton(
                    height: 50.0,
                    minWidth: 400,
                    color: Colors.red,
                    child:
                        Text('Logout', style: TextStyle(fontSize: 18,letterSpacing: 0.3, color: Colors.white)),
                    onPressed: () async {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      preferences.clear();
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil('/LoginPage', (Route<dynamic> route) => false);
                      //Navigator.of(context).pushReplacementNamed("/LoginPage");
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

  changePassword(context) {
    Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (BuildContext context) => new SetPasswordPage(),
        ));
  }
}
