import 'package:at/Weighting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  _SettingsMeasurementState createState() => _SettingsMeasurementState(
      /*textColor: TextStyle(
      color: Colors.green,
    ),*/
      );
}

class _SettingsMeasurementState extends State<SettingsScreen> {
  //_CalibMeasurementState ({this.textColor}) ;

  addValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('doubleCalibration', calibValue);
    prefs.setDouble('doubleThreshold', thresholdValue);
    //print('Stored' '$doubleValue');
  }

  double calibValue;
  double calibOffset;
  bool calib;
  double thresholdValue;
  String dropdownValue = 'A-Weighting';
  // Um text einzulesen und auf den eingegebenen wert zuzugreifen braucht man einen controller
  final calibValueController = TextEditingController();
  final thresholdValueController = TextEditingController();

  @override
  void dispose() {
    thresholdValueController.dispose();
    calibValueController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    calibValue = 0;
    thresholdValue = 0;
    //getThresholdValue();
    //getDoubleValuesSF();
    super.initState();
  }

  Widget build(BuildContext context) {
    TextStyle buttonText = TextStyle(
      fontSize: 15.0,
      color: Colors.green,
      fontWeight: FontWeight.w500,
      fontFamily: "Merriweather",
    );

    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0), // here the desired height
        child: AppBar(
          title: Text(
            'Settings',
            //style: textColor,
            style: TextStyle(color: Colors.green),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[850],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //---------------- Threshold Value------------------
            Column(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      'Set threshold value:',
                      style: TextStyle(color: Colors.green),
                    )),
                Container(
                  decoration: containerBorder(),
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text('Threshold Value:',
                            style: TextStyle(color: Colors.green)),
                      ),
                      Expanded(
                        child: TextField(
                          controller: thresholdValueController,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            enabledBorder: UnderlineInputBorder(// Warum 2 mal?
                                // borderSide: BorderSide(color: Colors.green),
                                ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            hintText: "$thresholdValue dB",
                            labelStyle: new TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (double.tryParse(thresholdValueController.text) !=
                              null) {
                            if (double.tryParse(thresholdValueController.text) <
                                0) {
                              setState(() {
                                //ACHTUNG WICHTIG! Die setState funktion triggert die build funktion des gesamten screens!
                                thresholdValue = 0;
                              });
                            } else {
                              setState(() {
                                thresholdValue = double.tryParse(
                                    thresholdValueController.text);
                                // print('Threshold set to ' '$thresholdValue' ' dB');
                              });
                            }
                          } else {
                            setState(() {
                              // default wert wenn zB ein buchstabe eingetippt wird
                              thresholdValue = 70;
                            });
                          }
                          print('Threshold set to ' '$thresholdValue' ' dB');
                          //addThreshold();

                          addValue();
                          //getThresholdValue();
                          thresholdValueController.clear();
                        },
                        child: Text('Set',
                            style: TextStyle(color: Colors.grey[800])),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Divider(
              color: Colors.grey[850],
              //height: 30,
              thickness: 2,
              //indent: 0,
              //endIndent: 0,
            ),

//---------------- Calibration Offset------------------
            Column(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      'Set calibration offset:',
                      style: TextStyle(color: Colors.green),
                    )),
                Container(
                  decoration: containerBorder(),
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              'Calibrate:',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: calibValueController,
                              textAlign: TextAlign.right,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                enabledBorder: UnderlineInputBorder(
                                    // Warum 2 mal?
                                    // borderSide: BorderSide(color: Colors.green),
                                    ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green),
                                ),
                                hintText: "$calibValue dB",
                                labelStyle: new TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () {
                              if (double.tryParse(calibValueController.text) !=
                                  null) {
                                setState(() {
                                  calibValue =
                                      double.tryParse(calibValueController.text);
                                });
                              } else {
                                setState(() {
                                  calibValue = 0;
                                });
                              }
                              print('Calib set to ' '$calibValue' ' dB');
                              addValue();
                              // getDoubleValuesSF();
                              calibValueController.clear();
                            },
                            child: Text(
                              'Set',
                              style: TextStyle(color: Colors.grey[800]),
                            ),
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        calibValue += 1;
                        print('Calib set to ' '$calibValue' ' dB');
                      });
                    },
                    child: Text(
                      '+1 dB',
                      style: new TextStyle(
                          fontSize: 15.0,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Merriweather"),
                    ),
                    color: Colors.grey[800],
                  ),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        calibValue -= 1;
                        print('Calib set to ' '$calibValue' ' dB');
                      });
                    },
                    child: Text(
                      '-1 dB',
                      style: new TextStyle(
                          fontSize: 15.0,
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Merriweather"),
                    ),
                    color: Colors.grey[700],
                  ),
                ],
              ),
            ),

            Divider(
              color: Colors.grey[850],
              //height: 20,
              thickness: 2,
              //indent: 0,
              //endIndent: 0,
            ),

            /*

            Container(
              padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ButtonTheme(
                          minWidth: 100.0,
                          height: 100.0,
                          child: RaisedButton(
                              color: Colors.grey[700],
                              child: Text(
                                'A-Weighting',
                                style: buttonText,
                              ),
                              onPressed: () {}),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ButtonTheme(
                          minWidth: 100.0,
                          height: 100.0,
                          child: RaisedButton(
                              color: Colors.grey[700],
                              child: Text(
                                'B-Weighting',
                                style: buttonText,
                              ),
                              onPressed: () {}),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ButtonTheme(
                          minWidth: 100.0,
                          height: 100.0,
                          child: RaisedButton(
                              color: Colors.grey[700],
                              child: Text(
                                'C-Weighting',
                                style: buttonText,
                              ),
                              onPressed: () {}),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ButtonTheme(
                          minWidth: 100.0,
                          height: 100.0,
                          child: RaisedButton(
                              color: Colors.grey[700],
                              child: Text(
                                'D-Weighting',
                                style: buttonText,
                              ),
                              onPressed: () {}),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
*/
//---------------- Weighting------------------
            Column(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      'Select weighting:',
                      style: TextStyle(color: Colors.green),
                    )),
                Container(
                  decoration: containerBorder(),
                  padding: EdgeInsets.all(5.0),
                  margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.green,
                    ),
                    iconSize: 30,
                    style: TextStyle(color: Colors.green),
                    underline: Container(
                      height: 1,
                      color: Colors.green,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'A-Weighting',
                      'B-Weighting',
                      'C-Weighting',
                      'D-Weighting'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget myWidget() {
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      decoration: containerBorder(),
    );
  }

  BoxDecoration containerBorder() {
    return BoxDecoration(
      color: Colors.grey[800],
      border: Border.all(
        width: 2,
        color: Colors.green,
      ),
    );
  }
}
