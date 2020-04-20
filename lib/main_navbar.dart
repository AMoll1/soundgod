import 'package:flutter/material.dart';
import 'home_navbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'SoundGod',
        theme: ThemeData(

        //primarySwatch: Colors.pink,
//        canvasColor: const Color(0xFF000000),
        brightness: Brightness.dark,
//        accentColor: const Color(0xFF4ab312),


            primaryTextTheme: TextTheme(
                title: TextStyle(
                    color: Colors.green
                ),
                    body1 :TextStyle(
                color: Colors.green

            ),
              body2 :TextStyle(
                  color: Colors.green

              ),
              button: TextStyle(
                color: Colors.green
              )
            )

     ),
      home: Home(),
    );
  }
}