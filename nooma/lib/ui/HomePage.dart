import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() =>  _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  final List<Widget> _children = [];
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // this will be set when a new tab is tapped
        items: [

          BottomNavigationBarItem(
            icon: new Icon(Icons.group),
            title: new Text('Rooms'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings')
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: _children[_currentIndex],
    );
  }
}