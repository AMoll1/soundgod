import 'package:flutter/material.dart';
import 'about.dart';
import 'calib.dart';
import 'main.dart';
import 'history.dart';



class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}
class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeMeasurement(),
    CalibrationScreen(),
    HistoryScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Soundmeter'),
      ),*/
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, // new
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.fiber_manual_record),
              title: Text('Measurement'),
              backgroundColor: Colors.grey[850],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.adjust),
              title: Text('Kalibrieren'),
              backgroundColor: Colors.grey[850],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time),
              title: Text('History'),
              backgroundColor: Colors.grey[850],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('About'),
              backgroundColor: Colors.grey[850],
            ),
          ]
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}