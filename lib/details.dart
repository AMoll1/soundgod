import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'measurement.dart';
import 'dart:io';

final DateFormat dateFormat = new DateFormat('HH:mm dd-MM-yyyy');
final NumberFormat txtFormat = new NumberFormat('###.##');

class DetailView extends StatelessWidget {
  final Measurement measurement;

  //Konstruktor
  DetailView({Key key, @required this.measurement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[800],
      /*title: Text(
        'Details',
        //measurement.name,
        style: TextStyle(
            color: Colors.green, decoration: TextDecoration.underline),
        textAlign: TextAlign.center,
      ),*/
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Container(
        width: MediaQuery.of(context).size.width, //Breit AlertDialog
        height: MediaQuery.of(context).size.height * 0.6, //Länge AlertDialog
        //popup view scrollable
        child: SingleChildScrollView(
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildDetailView(),
              //_buildLogoAttribution(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          //color: Colors.grey[850],
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.green,
          child: const Text('close'),
        ),
      ],
    );
  }

  Widget _buildDetailView() {
    TextStyle stl = new TextStyle(
      fontSize: 15.0,
      color: Colors.green,
    );
    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //SizedBox(height: 5.0),
            Card(
              color: Colors.grey[850],
              child: Text(
                'Measurement Data',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Expanded(
                  child: Text('DateTime:', style: stl),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    dateFormat
                        .format(DateTime.tryParse(measurement.dateTime))
                        .toString(),
                    style: stl,
                  ),
                  flex: 3,
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Latitude:',
                    style: stl,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    measurement.latitude.toString(),
                    style: stl,
                  ),
                  flex: 3,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Longitude:',
                    style: stl,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    measurement.longitude.toString(),
                    style: stl,
                  ),
                  flex: 3,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Sound min:',
                    style: stl,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    txtFormat.format(measurement.soundMin).toString() + " dB",
                    style: stl,
                  ),
                  flex: 3,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Sound max:',
                    style: stl,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    txtFormat.format(measurement.soundMax).toString() + " dB",
                    style: stl,
                  ),
                  flex: 3,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Sound avg:',
                    style: stl,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    txtFormat.format(measurement.soundAvg).toString() + " dB",
                    style: stl,
                  ),
                  flex: 3,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Sound duration:',
                    style: stl,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    measurement.soundDuration.toString() + " s",
                    style: stl,
                  ),
                  flex: 3,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 5.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              color: Colors.grey[850],
              child: Text(
                'Device Data',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'ID Device:',
                    style: stl,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    measurement.idDevice.toString(),
                    style: stl,
                  ),
                  flex: 3,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Manufacturer:',
                    style: stl,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    measurement.manufacturer.toString(),
                    style: stl,
                  ),
                  flex: 3,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Model:',
                    style: stl,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    measurement.model.toString(),
                    style: stl,
                  ),
                  flex: 3,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    Platform.isAndroid ? 'SDK Version:' : 'OS Version:',
                    style: stl,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    Platform.isAndroid
                        ? measurement.sdkVersion.toString()
                        : measurement.osVersion.toString(),
                    style: stl,
                  ),
                  flex: 3,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    measurement.isPhysicalDevice == 1
                        ? 'PhysicalDevice:'
                        : 'PhysicalDevice:',
                    style: stl,
                  ),
                  flex: 2,
                ),
                Expanded(
                  child: Text(
                    measurement.isPhysicalDevice == 1 ? 'TRUE' : 'FALSE',
                    style: stl,
                  ),
                  flex: 3,
                ),
              ],
            ),

            /*Text(
              'sdk Version: ' + measurement.sdkVersion,
              style: stl,
            ),*/
          ],
        ),
      ],
    );
  }
}

//StatefulWidget
/*
class DetailView extends StatefulWidget {

  final Measurement measurement;
  //Konstruktor
  DetailView({Key key, @required this.measurement}) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState(measurement);
}

class _DetailViewState extends State<DetailView> {

  Measurement measurement;

  _DetailViewState(this.measurement); //Konstruktor

/*
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin(); // instantiate device info plugin
  AndroidDeviceInfo androidDeviceInfo;
  IosDeviceInfo iosDeviceInfo;

  String manuf, mod, idDev, osVers;
  int sdkVers;


  @override
  void initState() {
    super.initState();
    //getDeviceInfoAndroid();
   // getDeviceInfoIos();
  }

  void getDeviceInfoAndroid() async {
    androidDeviceInfo =
    await deviceInfo.androidInfo; // instantiate Android Device Information
    setState(() {
      sdkVers = androidDeviceInfo.version.sdkInt;
      //osVers = androidDeviceInfo.version.baseOS;
      mod = androidDeviceInfo.model;
      manuf = androidDeviceInfo.manufacturer;
      idDev = androidDeviceInfo.id;
    });
  }

  void getDeviceInfoIos() async {
    iosDeviceInfo =
    await deviceInfo.iosInfo; // instantiate ios Device Information
    setState(() {
      //sdkVers = iosDeviceInfo.version.sdkInt;
      osVers = iosDeviceInfo.systemVersion;
      mod = iosDeviceInfo.model;
      manuf = iosDeviceInfo.name;
      idDev = iosDeviceInfo.utsname.version;
    });
  }

*/
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[800],
      title: Text(
        'Derails',
        //measurement.name,
        style: TextStyle(
            color: Colors.green, decoration: TextDecoration.underline),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height * 0.6,
        child: SingleChildScrollView(
          //popup view scrollable
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildDetailView(),
              //_buildLogoAttribution(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          //color: Colors.grey[850],
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.green,
          child: const Text('close'),
        ),
      ],
    );
  }

  Widget _buildDetailView() {
    TextStyle stl = new TextStyle(
      fontSize: 15.0,
      color: Colors.green,
    );

    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(height: 5.0),
            Card(
              color: Colors.grey[850],
              child: Text(
                'Measurement Data',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'DateTime: ' + dateFormat.format(DateTime.tryParse(measurement.dateTime)).toString(),
              style: stl,
            ),
            Text(
              'Latitude: ' + measurement.latitude.toString(),
              style: stl,
            ),
            Text(
              'Longitude: ' + measurement.longitude.toString(),
              style: stl,
            ),
            Text(
              'Sound min: ' + txtFormat.format(measurement.soundMin).toString()+" dB",
              style: stl,
            ),
            Text(
              'Sound max: ' + txtFormat.format(measurement.soundMax).toString()+" dB",
              style: stl,
            ),
            Text(
              'Sound avg: ' + txtFormat.format(measurement.soundAvg).toString()+" dB",
              style: stl,
            ),
            Text(
              'Sound duration: ' + measurement.soundDuration.toString()+ " s",
              style: stl,
            ),
          ],
        ),
        SizedBox(height: 5.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              color: Colors.grey[850],
              child: Text(
                'Device Data',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'ID Device: ' + measurement.idDevice.toString(),
              style: stl,
            ),
            Text(
              'Manufacturer: ' + measurement.manufacturer.toString(),
              style: stl,
            ),
            Text(
              'Model: ' + measurement.model.toString(),
              style: stl,
            ),
            Text(
              'sdk Version: ' + measurement.sdkVersion.toString(),
              style: stl,
            ),
            Text(
              Platform.isAndroid
                  ? 'sdk Version: ' + measurement.sdkVersion.toString()
                  : 'os Version: ' + measurement.osVersion.toString(),
              style: stl,
            ),
            Text((measurement.isPhysicalDevice==1) ? 'IsPhysicalDevice: TRUE' :'IsPhysicalDevice: FALSE',
              style: stl,
            ),
          ],
        ),
      ],
    );
  }
}

*/
