import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';



void main() {
  runApp(MaterialApp(
    home: CalibrationScreen(
      navstyle: new TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.w500,
        fontFamily: "Merriweather",
      )),

    ),);

}

class CalibrationScreen extends StatelessWidget {
  CalibrationScreen({this.navstyle});
  final TextStyle navstyle;



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[


            Text('Calibrate  ', style: TextStyle(
              color: Colors.green,

            ),),
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
              color: Colors.grey[900],
              child: Image.asset('assets/logov1.jpg'),
            ),

          ],

        ),

        backgroundColor: Colors.grey[900],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Text('Kalibrieren Sie!', style: navstyle),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              RaisedButton(
                onPressed: () {
                  //METHODE
                },
                child: Text('+', style:new TextStyle(fontSize:15.0,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Merriweather"),),
                color: Colors.grey[800],

              ),
              RaisedButton(
                onPressed: () {
                  //METHODE
                },
                child: Text('-', style:new TextStyle(fontSize:15.0,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Merriweather"),),
                color: Colors.grey[700],

              ),
            ],
          ),

          TextField(

          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[

              Row(
                children: <Widget>[
                  Text("[dB/Hz]", style:new TextStyle(fontSize:30.0,
                      color: Colors.green,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Merriweather"),),
                ],
              ),

            ],
          ),

        ],

      ),

      /*

      WIRD NICHT MEHR BENÖTIGT!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: 1,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.fiber_manual_record ,color: Colors.green,),
              title: Text("MEAS", style: navstyle),

              backgroundColor: Colors.grey[900],
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.adjust,color: Colors.green,),
              title: Text("CALI", style: navstyle),

              backgroundColor: Colors.grey[900],
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.access_time, color: Colors.green,),
              title: Text('History', style: navstyle),

              backgroundColor: Colors.grey[900],
            ),

            BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.green,),
              title: Text('History', style: navstyle),

              backgroundColor: Colors.grey[900],
            ),

          ]
      ),


      */

    );

  }
}




