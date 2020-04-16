import 'package:at/calib.dart';
import 'package:at/history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "about.dart";
import "details.dart";




// --- Main program ------------------------------------------------------------
void main() => runApp(MaterialApp(
  home: HomeMeasurement(),
));

// --- Stateless widget to use hot reload --------------------------------------
class HomeMeasurement extends StatefulWidget {
  @override
  _HomeMeasurementState createState() => _HomeMeasurementState();
}

class _HomeMeasurementState extends State<HomeMeasurement> {

  int thresholdvalue = 43;
  String filename = '';




  /*
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);

      if(_selectedIndex==3){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutScreen()),
        );
      }

    });
  }

   */



  @override
  Widget build(BuildContext context) {
    return Scaffold(


      // --- App Bar at the top ------------------------------------------------
      appBar: AppBar(
        title: Text('Measurement Screen', style: TextStyle(
          color: Colors.green,
        ),),
        centerTitle: true,
        backgroundColor: Colors.grey[850],

      ),

      // --- The Body ----------------------------------------------------------
      // --- Zeilen erstellen --------------------------------------------------
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[

          // --- Zeile 1: Input ------------------------------------------------
          Container(
              padding: EdgeInsets.all(5.0),
              color: Colors.grey[800],
              child: Column(


                children: <Widget>[
                  Text(
                    'INPUT',

                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                      //color: Colors.cyanAccent[700],
                    ),
                  ),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text('Set threshold value:'),

                      ),
                      Text('$thresholdvalue'),
                      Text(' dB '),
                      RaisedButton(
                        onPressed: () {
                          print('Threshold set');
                        },
                        child: Text('Set'),
                        color: Colors.green,
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Set file name: '),
                      Expanded(
                        child: TextField(

                        ),
                      ),
                      //Text('meas_1 '),
                      RaisedButton(
                        onPressed: () {
                          print('Measurement name set');
                        },
                        child: Text('Set'),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              )

          ),


          // --- Zeile 2: Icon button ------------------------------------------

          //IDEE ZUM BUTTON (von Dave)
          //Wenn man auf den IconButton drückt soll darunter in einem TextLabel
          // "RECORDING" bzw. "Bitte drücken Sie!" oder sowas stehen..
          // sodass man weiß, ob gerade aufgenommen wird.
          //vielleicht könnte man direkt unter dem "Start Measurement"-Container
          //noch einen Container einblenden, wo das Frequenzspekturm abgebildet wird? --> Schwierigkeit: next level?

          Container(
            decoration: containerBorder(),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'START MEASUREMENT',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                    //color: Colors.cyanAccent[700],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(width: 2, color: Colors.green),),
                  child: IconButton(
                    onPressed: (){
                      print("Measurement started");
                      setState(() {
                        thresholdvalue += 1;
                        //code hier einfügen
                      });
                    },
                    icon: Icon(Icons.mic, color: Colors.green,),
                    color: Colors.green,
                    iconSize: 100.0,

                   ),



                ),

                Text('Click to start/stop the measurement', style:
                TextStyle(
                  color: Colors.green,
                ),
                ),
              ],
            ),
          ),


          // --- Zeile 3: Raised button ----------------------------------------
          /*Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.grey[300],

            child: RaisedButton(
              onPressed: () {
                print('Measurement started');
              },
              child: Text('Start measurement'),
              color: Colors.cyanAccent[700],
            ),
          ),*/

          // --- Zeile 4: Output -----------------------------------------------
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5.0),
              color: Colors.grey[800],
              child: Column(
                  children: <Widget>[
                    Text(
                      'OUTPUT',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        //color: Colors.cyanAccent[700],
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text('Time:'),
                          ),
                          Text('65'),
                          Text(' s'),
                        ]
                    ),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text('Average value:'),
                          ),
                          Text('50'),
                          Text(' dB'),
                        ]
                    ),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text('Max value:'),
                          ),
                          Text('90'),
                          Text(' dB'),
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text('Min value:'),
                          ),
                          Text('40'),
                          Text(' dB'),
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text('Actual value:'),
                          ),
                          Text('70'),
                          Text(' dB'),
                        ]
                    ),
                  ]
              ),
            ),
          ),
        ],
      ),

    );
  }

  Widget myWidget(){
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      decoration: containerBorder(),

    );
  }

  BoxDecoration containerBorder(){
    return BoxDecoration(
      color: Colors.grey[800],
      border: Border.all(
        width: 2,
        color: Colors.green,
      ),
    );
  }
}
















// --- Backup code ----------------------------------------------------------
/*child: Image(),*/

/*CircleAvatar(
backgroundImage: AssetImage('asstes/thum.jpg'),
radius: 40.0,
),*/


/*Divider(
height: 60.0,
)*/

/*body: Center()*/

/*child: Icon(
          Icons.speaker,
          color: Colors.cyanAccent[700],
        ),'*/



/*child: Text(
          'Threshold value:',
          style: TextStyle(
            fontSize: 12.0,
            //fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.grey[800],
          ),
        ),*/

/*SizedBox(height: 30.0),*/

/*
floatingActionButton: FloatingActionButton(
child: Text('Start Measurement'),
backgroundColor: Colors.cyanAccent[700],
),*/




/*
child: RaisedButton.icon(
onPressed: () {
print('Measurement started');
},
icon: Icon(
Icons.adjust
),
label: Text('Start measurement'),
color: Colors.cyanAccent[700],
),*/




/*
child: IconButton(
onPressed: () {
print('Measurement started');
},
icon: Icon(Icons.adjust),
color: Colors.cyanAccent[700],
iconSize: 50.0,
)*/


/*body: Container(
padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
margin: EdgeInsets.all(0),
color: Colors.grey[700],
child: Text('Hello'),
),*/


/*body: Padding(
padding: EdgeInsets.all(10),
child: Text('Hello'),
),*/


/*      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          Text('Set threshold value:'),

          RaisedButton(
            onPressed: () {
              print('Threshold set');
            },
            child: Text('Set'),
            color: Colors.cyanAccent[700],
          ),
        ],
      ),*/