import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

//Beim Kalibriervorgang
//Schritt 1: 20 Frequenzen, die man mit dem Kalibriergerät vergleicht, eingeben --> in Input Feld eingeben
//Schritt 2: Nach jeden Step der Eingabe ins Input-Feld soll die momentane Liste mit Werten dargestellt
// werden: [10, 11, 25, 50, ...] --> man soll die Werte in der Liste willkürlich löschen können
//Schritt 3: Rechenoperationen mit den 20 Frequenzen machen --> Mittelwert bilden und auf Frequenzspektrum von
// Liste von View "Measurement" aufaddieren/subtrahieren


void main() {
  runApp(MaterialApp(
    home: CalibrationScreen(
      ),

    ),);

}

class CalibrationScreen extends StatelessWidget {

  CalibrationScreen({this.bodystyle});
  final TextStyle bodystyle;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
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
          Text('Kalibrieren Sie!', style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w500,
            fontFamily: "Merriweather",
          ),

          ),

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

    );

  }
}




