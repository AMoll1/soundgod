import 'package:flutter/material.dart';
import 'home_navbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Soundmeter',
      home: Home(),
    );
  }
}