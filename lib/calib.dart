import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    home: Calibration(),

  ));
}

class Calibration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(

        title:

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Text('Kalibrieren  '),
            Icon(
              Icons.adjust,
              color: Colors.green,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),

            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),

            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 35.0),
              color: Colors.grey[750],
              child: Image.asset('assets/logov1.jpg'),
            ),

          ],

        ),

        backgroundColor: Colors.grey[850],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Text('Kalibrieren Sie!', style: TextStyle(fontSize:38.0)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              RaisedButton(
                onPressed: () {
                  //METHODE
                },
                child: Text('+'),
                color: Colors.grey[850],

              ),
              RaisedButton(
                onPressed: () {
                  //METHODE
                },
                child: Text('-'),
                color: Colors.grey[750],

              ),
            ],
          ),

          TextField(),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[

              Row(
                children: <Widget>[
                  Text("[dB/Hz]", style: TextStyle(fontSize:25.0),),
                ],
              ),

            ],
          ),

        ],

      ),

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.fiber_manual_record),
              title: Text('Aufnehmen'),
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
}




