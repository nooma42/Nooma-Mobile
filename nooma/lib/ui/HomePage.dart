import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:nooma/ui/roomsTab.dart';
import 'package:nooma/ui/SettingsTab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() =>  _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(),
    SettingsTab(),
  ];
  String username;


  _getPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString('username');
  }

  @override
  void initState() {
    super.initState();
    _getPreferences();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:new Theme(
        data: Theme.of(context).copyWith(
      // sets the background color of the `BottomNavigationBar`
        canvasColor: Color(0xff1f1c29),
        // sets the active color of the `BottomNavigationBar` if `Brightness` is light
        primaryColor: Colors.deepPurpleAccent,
        textTheme: Theme
            .of(context)
            .textTheme
            .copyWith(caption: new TextStyle(color: Colors.grey))),
    child: BottomNavigationBar(
        currentIndex: _currentIndex, // this will be set when a new tab is tapped
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.message),
            title: new Text('Rooms'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings')
          )
        ],
      ),),
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
    );
  }

  //on changing tab, update the tab index state
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}