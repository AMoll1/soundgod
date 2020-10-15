import 'package:flutter/material.dart';
import '../lib/about.dart';
import '../lib/calib.dart';
import '../lib/main.dart';
import '../lib/history.dart';
import 'package:vibration/vibration.dart';

/*

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}
class _HomeState extends State<Home> {

  TextStyle navstyle= new TextStyle(
  color: Colors.green,
  fontWeight: FontWeight.w500,
  fontFamily: "Merriweather",
  );


  void vibrate ()async {

    if (await Vibration.hasVibrator()) {

      if (await Vibration.hasAmplitudeControl()) {
        Vibration.vibrate(duration: 100, amplitude: 255);
      }else {
        Vibration.vibrate(duration: 100);
      }
    }
  }

  int _currentIndex = 0;                    //index der aktuellen registerkarte
  final List<Widget> _children = [          //liste der einzelnen views
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
              icon: Icon(Icons.mic ,color: Colors.green),
              title: Text('Measurement',style: navstyle),
              backgroundColor: Colors.grey[850],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.adjust,color: Colors.green),
              title: Text('Calibration',style: navstyle),
              backgroundColor: Colors.grey[850],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_time,color: Colors.green),
              title: Text('History',style: navstyle),
              backgroundColor: Colors.grey[850],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,color: Colors.green),
              title: Text('About',style: navstyle),
              backgroundColor: Colors.grey[850],
            ),
          ]
      ),
    );
  }


  //index der abgegriffenen registerkarte wird aufgenommen und setstate aufgerufen
  //aktualisierter registerkartenindex wird gesendet un drichtige registerkarte dargestellt
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      vibrate();
    });
  }
}

 */