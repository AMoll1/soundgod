import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp(
  firstWidget: Text("Passed From Main"),
  secondWidget: Text("Second Passed..."),
));



class MyApp extends StatelessWidget {
  MyApp({this.firstWidget, this.secondWidget});
  final Widget firstWidget;
  final Widget secondWidget;
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: <Widget>[
                firstWidget,
                secondWidget
          ],
        ),

      ),

      );

  }
}
