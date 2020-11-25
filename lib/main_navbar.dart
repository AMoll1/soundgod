import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'device_data.dart';
import 'about.dart';
import 'settings.dart';
import 'history.dart';
import 'package:vibration/vibration.dart';
import 'main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SoundGod',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    DeviceData.readDeviceData();
    DeviceData.getLocation();
    super.initState();
  }

  void vibrate() async {
    if (await Vibration.hasVibrator()) {
      if (await Vibration.hasAmplitudeControl()) {
        Vibration.vibrate(duration: 100, amplitude: 255);
      } else {
        Vibration.vibrate(duration: 100);
      }
    }
  }

  int _currentIndex = 0; //index der aktuellen registerkarte
  final List<Widget> _children = [
    HomeMeasurement(),
    HistoryScreen(),
    SettingsScreen(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey[700],
        showUnselectedLabels: true,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Measurement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'About',
          ),
        ],
      ),
    );
  }

  //index der abgegriffenen registerkarte wird aufgenommen und setstate aufgerufen
  //aktualisierter registerkartenindex wird gesendet und die richtige registerkarte dargestellt
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      vibrate();
    });
  }
}
