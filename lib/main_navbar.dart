import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'DeviceData.dart';
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
        //primarySwatch: Colors.pink,
        //canvasColor: const Color(0xFF000000),
        brightness: Brightness.dark,
        //accentColor: const Color(0xFF4ab312),
/*
          primaryTextTheme: TextTheme(
              title: TextStyle(color: Colors.green),
              body1: TextStyle(color: Colors.green),
              body2: TextStyle(color: Colors.green),
              button: TextStyle(color: Colors.green))
              */
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
/*
  TextStyle navstyle= new TextStyle(
    color: Colors.green,
    fontWeight: FontWeight.w500,
    fontFamily: "Merriweather",
  );
*/

  @override
  void initState() {
    DeviceData.readDeviceData();
    DeviceData.getLocation();
    super.initState();

    /*
    _now = DateTime.now().millisecond.toString();

    // defines a timer
    _everySecond = Timer.periodic(Duration(milliseconds: 300), (Timer t) {
      setState(() {
        _now = DateTime.now().millisecond.toString();
      });
    }


    );

*/
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
    //liste der einzelnen views
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
            icon: Icon(Icons.adjust),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'About',
          ),
        ],
      ),
    );
  }

  //index der abgegriffenen registerkarte wird aufgenommen und setstate aufgerufen
  //aktualisierter registerkartenindex wird gesendet un drichtige registerkarte dargestellt
  void onTabTapped(int index) {
    /*
    if(_currentIndex==0 && index != 0){


    }
    */

    setState(() {
      _currentIndex = index;
      vibrate();
    });
  }
}
