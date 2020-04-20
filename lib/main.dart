// Within this view the user can take a measurement

import 'package:at/calib.dart';
import 'package:at/history.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "about.dart";
import "details.dart";
import 'meas.dart';




// --- Main program ------------------------------------------------------------
void main() => runApp(MaterialApp(
  home: HomeMeasurement(
  ),
),
);




// --- Statefull widget to use hot reload, a statefull widget can change its state over time and it can use dynamic data --------------------------------------
class HomeMeasurement extends StatefulWidget {

  _HomeMeasurementState createState() => _HomeMeasurementState(
    textColor: TextStyle(
      color: Colors.green,
    ),
  );
}




// --- Create a state that can be updated every time a user makes an input -----
class _HomeMeasurementState extends State<HomeMeasurement> {
  _HomeMeasurementState({this.textColor});
  final TextStyle textColor;                                                    // Please comment

  bool isActive = false;                                                        // Please comment

  // Variable deklaration and initialization (with default values) to store user input and output
  int recThresholdvalue = 20;
  String recFilename = 'default';
  bool recButtonStatus = false;


  final ThresholdValueController = TextEditingController();                     // Um text einzulesen und auf den eingegebenen wert zuzugreifen braucht man einen controller
  final FileNameController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    ThresholdValueController.dispose();
    FileNameController.dispose();
    super.dispose();
  }

  /*int _selectedIndex = 0;                                                     // Please comment
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
  }*/



  @override
  Widget build(BuildContext context) {                                          // Der widget tree der hier erstellt wird kann jedesmal neu gebaut werden wenn sich eine variable von oben ändert
    return Scaffold(                                                            // Das Scaffold widget ist der beginn unseres widget-trees ab hier verästeln sich die widgets nach unten

      // --- App Bar at the top ------------------------------------------------
      appBar: AppBar(
        title: Text('Measurement', style: textColor,),
        centerTitle: true,
        backgroundColor: Colors.grey[850],
      ),


      // --- The Body ----------------------------------------------------------
      // --- Zeilen erstellen --------------------------------------------------
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[

          // --- Zeile 1: Input section ----------------------------------------
          Container(
              padding: EdgeInsets.all(3.0),                                       //NICHT MEHR ALS 3.0 SONST KONFLIKT MIT EINGABETASTATUR!
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
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text('Set threshold value:', style: textColor),
                      ),
                      Expanded(
                        child: TextField(
                          controller: ThresholdValueController,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0 ,vertical: 10.0),
                            enabledBorder: UnderlineInputBorder(                // Warum 2 mal?
                              // borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            hintText: "$recThresholdvalue dB",
                            labelStyle: new TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          if(int.tryParse(ThresholdValueController.text) != null){
                            if(int.tryParse(ThresholdValueController.text) < 0){
                              setState(() {                                             //ACHTUNG WICHTIG! Die setState funktion triggert die build funktion des gesamten screens!
                                recThresholdvalue = 0;
                              });
                            }
                            else{
                              setState(() {
                                recThresholdvalue = int.tryParse(ThresholdValueController.text);
                              });
                            }
                          }
                          else{setState(() {                                    // default wert wenn zB ein buchstabe eingetippt wird
                            recThresholdvalue = 20;
                          });}
                          print('Threshold set to ' '$recThresholdvalue' ' dB');
                          ThresholdValueController.clear();
                        },
                        child: Text('Set', style: TextStyle(color: Colors.grey[800])),
                        color: Colors.green,
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Set file name: ', style: textColor),
                      Expanded(
                        child: TextField(
                          controller: FileNameController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0 ,vertical: 10.0),
//                            fillColor: Colors.grey[400],
//                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            hintText: recFilename + '.csv',
                            labelStyle: new TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      //Text('meas_1 '),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            if(FileNameController.text.isNotEmpty){
                              if(FileNameController.text.contains('.') || FileNameController.text.contains(',') || FileNameController.text.contains('#') || FileNameController.text.contains('-') || FileNameController.text.contains('+')){ //Das muss einfacher gehn um sonderzeichen in der benennung auszuschließen
                                recFilename = 'default';
                              }
                              else{
                                recFilename = FileNameController.text;
                              }
                            }
                            else{recFilename = 'default';}
                          });
                          print('Measurement name set to ' + recFilename);
                          FileNameController.clear();
                        },
                        child: Text('Set', style:TextStyle(
                          color: Colors.grey[800],
                        ),),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              )

          ),







          // --- Zeile 2: Icon button ------------------------------------------

          //IDEE ZUM BUTTON
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
                  recButtonStatus ? 'RECORDING...' : 'START MEASUREMENT',

                  //'START MEASUREMENT',                                        // comment?
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
                    border: Border.all(width: 2, color: recButtonStatus ? Colors.redAccent : Colors.green),),
                  child: IconButton(
                    onPressed: (){
                      setState(() {
                        if(recButtonStatus == false){
                          recButtonStatus = true;
                          print("Measurement started");
                          meas measurement = new meas(recFilename, recThresholdvalue);
                          // audioaufnahme starten - code hier einfügen
                        }
                        else {
                          recButtonStatus = false;
                          print("Measurement stopped");
                          // aufnahme stoppen und messung abspeichern - code hier einfügen
                          // alert fenster das nachfragt ob messung gespeichert werden soll hier einfügen
                        };
                      });

                      /*setState(() {                                            // comment bitte
                        thresholdvalue += 1;
                        //code hier einfügen
                      });*/
                    },
                    icon: Icon(Icons.mic, color: recButtonStatus ? Colors.redAccent : Colors.green),
                    color: Colors.green,
                    iconSize: 100.0,
                  ),
                ),

                Text('Tap the mic icon to start/stop the measurement', style:
                TextStyle(
                  color: Colors.green,
                ),
                ),
              ],
            ),
          ),



          // --- Zeile 3: Output -----------------------------------------------
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5.0),
              color: Colors.grey[800],
              child: Column(
                  children: <Widget>[
                    Text(
                      'OUTPUT',
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
                            child: Text('Time:', style: textColor),
                          ),
                          Text('65', style: textColor),
                          Text(' s', style: textColor),
                        ]
                    ),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text('Average value:', style: textColor),
                          ),
                          Text('50', style: textColor ),
                          Text(' dB', style: textColor),
                        ]
                    ),

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text('Max value:', style: textColor),
                          ),
                          Text('90', style: textColor),
                          Text(' dB', style: textColor),
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text('Min value:', style: textColor),
                          ),
                          Text('40', style: textColor),
                          Text(' dB', style: textColor),
                        ]
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text('Actual value:', style: textColor),
                          ),
                          Text('70', style: textColor),
                          Text(' dB', style: textColor),
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