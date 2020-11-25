import 'package:at/weighting.dart';
import 'package:at/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  _SettingsMeasurementState createState() => _SettingsMeasurementState();
}

class _SettingsMeasurementState extends State<SettingsScreen> {
  int threshold;
  int calib1;
  int calib2;
  int calib3;
  int calib4;
  int calib5;
  String weighting;

  Future getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    threshold = prefs.getInt("threshold") ?? 0;
    calib1 = prefs.getInt('calib1') ?? 0;
    calib2 = prefs.getInt('calib2') ?? 0;
    calib3 = prefs.getInt('calib3') ?? 0;
    calib4 = prefs.getInt('calib4') ?? 0;
    calib5 = prefs.getInt('calib5') ?? 0;
    weighting = prefs.getString('weighting') ?? 'A';
    setState(() {});
  }

  setValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("threshold", threshold);
    await prefs.setInt('calib1', calib1);
    await prefs.setInt('calib2', calib2);
    await prefs.setInt('calib3', calib3);
    await prefs.setInt('calib4', calib4);
    await prefs.setInt('calib5', calib5);
    await prefs.setString('weighting', weighting);
  }

  void initWeighting() {
    switch (weighting) {
      case 'A':
        setSelected("A");
        break;
      case 'B':
        setSelected("B");
        break;
      case 'C':
        setSelected("C");
        break;
      case 'D':
        setSelected("D");
        break;
      case 'Z':
        setSelected("Z");
        break;
    }
  }

  @override
  void initState() {
    threshold = 0;
    calib1 = 0;
    calib2 = 0;
    calib3 = 0;
    calib4 = 0;
    calib5 = 0;
    weighting = 'A';
    getValues().whenComplete(() => initWeighting());
    super.initState();
  }

  setSelected(String val) {
    setState(() {
      weighting = val;
      setValues();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Text(
            'Settings',
            style: TextStyle(color: Colors.green),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[850],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //---------------- Threshold Value------------------
            Column(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(
                      'Set threshold:',
                      style: TextStyle(color: Colors.green),
                    )),
                Container(
                  decoration: containerBorder(),
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Threshold:', style: TextStyle(color: Colors.green)),
                      Text(
                        threshold.toString() + " dB",
                        textAlign: TextAlign.center,
                        style: calibTextBold(),
                      ),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            threshold += 5;
                            setValues();
                          });
                        },
                        child: Text(
                          '+5%',
                          style: btnText(),
                        ),
                        color: Colors.white24,
                      ),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            if (threshold >= 5) {
                              threshold -= 5;
                              setValues();
                            }
                          });
                        },
                        child: Text(
                          '-5%',
                          style: btnText(),
                        ),
                        color: Colors.white24,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Divider(
              color: Colors.grey[850],
              thickness: 2,
            ),

//---------------- Calibration Offset------------------

            Column(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'Calibration',
                      style: TextStyle(color: Colors.green),
                    )),
                Container(
                  decoration: containerBorder(),
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    calib1++;
                                    setValues();
                                  });
                                },
                                child: Text(
                                  '+1%',
                                  style: btnText(),
                                ),
                                color: Colors.white24,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    calib2++;
                                    setValues();
                                  });
                                },
                                child: Text(
                                  '+1%',
                                  style: btnText(),
                                ),
                                color: Colors.white24,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    calib3++;
                                    setValues();
                                  });
                                },
                                child: Text(
                                  '+1%',
                                  style: btnText(),
                                ),
                                color: Colors.white24,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    calib4++;
                                    setValues();
                                  });
                                },
                                child: Text(
                                  '+1%',
                                  style: btnText(),
                                ),
                                color: Colors.white24,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    calib5++;
                                    setValues();
                                  });
                                },
                                child: Text(
                                  '+1%',
                                  style: btnText(),
                                ),
                                color: Colors.white24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              calib1.toString() + "%",
                              textAlign: TextAlign.center,
                              style: calibTextBold(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              calib2.toString() + "%",
                              textAlign: TextAlign.center,
                              style: calibTextBold(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              calib3.toString() + "%",
                              textAlign: TextAlign.center,
                              style: calibTextBold(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              calib4.toString() + "%",
                              textAlign: TextAlign.center,
                              style: calibTextBold(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              calib5.toString() + "%",
                              textAlign: TextAlign.center,
                              style: calibTextBold(),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    calib1--;
                                    setValues();
                                  });
                                },
                                child: Text(
                                  '-1%',
                                  style: btnText(),
                                ),
                                color: Colors.white24,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    calib2--;
                                    setValues();
                                  });
                                },
                                child: Text(
                                  '-1%',
                                  style: btnText(),
                                ),
                                color: Colors.white24,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    calib3--;
                                    setValues();
                                  });
                                },
                                child: Text(
                                  '-1%',
                                  style: btnText(),
                                ),
                                color: Colors.white24,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    calib4--;
                                    setValues();
                                  });
                                },
                                child: Text(
                                  '-1%',
                                  style: btnText(),
                                ),
                                color: Colors.white24,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: RaisedButton(
                                onPressed: () {
                                  setState(() {
                                    calib5--;
                                    setValues();
                                  });
                                },
                                child: Text(
                                  '-1%',
                                  style: btnText(),
                                ),
                                color: Colors.white24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text("0Hz -\n440Hz",
                                textAlign: TextAlign.center,
                                style: calibText()),
                          ),
                          Expanded(
                            child: Text(
                              "440Hz -\n880Hz",
                              textAlign: TextAlign.center,
                              style: calibText(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "880Hz -\n3520Hz",
                              textAlign: TextAlign.center,
                              style: calibText(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "3520Hz -\n7000Hz",
                              textAlign: TextAlign.center,
                              style: calibText(),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "7000Hz -\n∞Hz",
                              textAlign: TextAlign.center,
                              style: calibText(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Divider(
              color: Colors.grey[850],
              thickness: 2,
            ),

//---------------- Weighting------------------
            Column(
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Text(
                      'Select weighting:',
                      style: TextStyle(color: Colors.green),
                    )),
                Container(
                  decoration: containerBorder(),
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: Column(
                    children: [
                      Theme(
                        //Farbe Radio buttons ändern (wrap row with Theme widget)
                        data: Theme.of(context)
                            .copyWith(unselectedWidgetColor: Colors.green),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Radio<String>(
                                value: 'A',
                                groupValue: weighting,
                                activeColor: Colors.green,
                                onChanged: (newValue) {
                                  setState(() {
                                    setSelected(newValue);
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: Radio<String>(
                                value: 'B',
                                groupValue: weighting,
                                activeColor: Colors.green,
                                onChanged: (newValue) {
                                  setState(() {
                                    setSelected(newValue);
                                    weighting = newValue;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: Radio<String>(
                                value: 'C',
                                groupValue: weighting,
                                activeColor: Colors.green,
                                onChanged: (newValue) {
                                  setState(() {
                                    setSelected(newValue);
                                    weighting = newValue;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: Radio<String>(
                                value: 'D',
                                groupValue: weighting,
                                activeColor: Colors.green,
                                onChanged: (newValue) {
                                  setState(() {
                                    setSelected(newValue);
                                    weighting = newValue;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: Radio<String>(
                                value: 'Z',
                                groupValue: weighting,
                                activeColor: Colors.green,
                                onChanged: (newValue) {
                                  setState(() {
                                    setSelected(newValue);
                                    weighting = newValue;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Text(
                            'A',
                            style: calibTextBold(),
                            textAlign: TextAlign.center,
                          )),
                          Expanded(
                              child: Text(
                            'B',
                            style: calibTextBold(),
                            textAlign: TextAlign.center,
                          )),
                          Expanded(
                              child: Text(
                            'C',
                            style: calibTextBold(),
                            textAlign: TextAlign.center,
                          )),
                          Expanded(
                              child: Text(
                            'D',
                            style: calibTextBold(),
                            textAlign: TextAlign.center,
                          )),
                          Expanded(
                              child: Text(
                            'Z',
                            style: calibTextBold(),
                            textAlign: TextAlign.center,
                          )),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle calibTextBold() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.green,
    );
  }

  TextStyle calibText() {
    return TextStyle(
      fontWeight: FontWeight.w100,
      color: Colors.green,
    );
  }

  TextStyle btnText() {
    return new TextStyle(
        fontSize: 15.0,
        color: Colors.green,
        fontWeight: FontWeight.w500,
        fontFamily: "Merriweather");
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
