import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/material.dart';



class HistoryScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: new AppBar(
        title: new Text('History'),
        centerTitle: true,
      ),
    );
  }
}