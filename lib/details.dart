import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'measurement.dart';
import 'dart:io';

final DateFormat dateFormat = new DateFormat('HH:mm dd-MM-yyyy');
final NumberFormat txtFormat = new NumberFormat('###.##');

class DetailView extends StatelessWidget {
  final Measurement measurement;

  DetailView({Key key, @required this.measurement}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle stl = new TextStyle(
      fontSize: 14.0,
      color: Colors.green,
    );

    return AlertDialog(
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Container(
        width: MediaQuery.of(context).size.width, //Breit AlertDialog
        height: MediaQuery.of(context).size.height * 0.6, //Länge AlertDialog
        //popup view scrollable
        child: SingleChildScrollView(
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
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
                    child: Text('Weighting:', style: stl),
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      measurement.weighting,
                      style: stl,
                    ),
                    flex: 4,
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text('DateTime:', style: stl),
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      dateFormat
                          .format(DateTime.tryParse(measurement.dateTime)),
                      style: stl,
                    ),
                    flex: 4,
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Sound min:',
                      style: stl,
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      txtFormat.format(measurement.soundMin).toString() +
                          " dB(" +
                          measurement.weighting +
                          ")",
                      style: stl,
                    ),
                    flex: 4,
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
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      txtFormat.format(measurement.soundMax).toString() +
                          " dB(" +
                          measurement.weighting +
                          ")",
                      style: stl,
                    ),
                    flex: 4,
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
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      txtFormat.format(measurement.soundAvg).toString() +
                          " dB(" +
                          measurement.weighting +
                          ")",
                      style: stl,
                    ),
                    flex: 4,
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
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      measurement.soundDuration.toString() + " s",
                      style: stl,
                    ),
                    flex: 4,
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Card(
                color: Colors.grey[850],
                child: Text(
                  'Location Data',
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
                      'Latitude:',
                      style: stl,
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      measurement.latitude.toString(),
                      style: stl,
                    ),
                    flex: 4,
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
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      measurement.longitude.toString(),
                      style: stl,
                    ),
                    flex: 4,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Address:',
                      style: stl,
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      measurement.address.toString(),
                      style: stl,
                    ),
                    flex: 4,
                  ),
                ],
              ),
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
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      measurement.idDevice,
                      style: stl,
                    ),
                    flex: 4,
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
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      measurement.manufacturer,
                      style: stl,
                    ),
                    flex: 4,
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
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      measurement.model,
                      style: stl,
                    ),
                    flex: 4,
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
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      Platform.isAndroid
                          ? measurement.sdkVersion
                          : measurement.osVersion,
                      style: stl,
                    ),
                    flex: 4,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'PhysicalDevice:',
                      // ? 'PhysicalDevice:'
                      //: 'PhysicalDevice:',
                      style: stl,
                    ),
                    flex: 3,
                  ),
                  Expanded(
                    child: Text(
                      measurement.isPhysicalDevice == 1 ? 'TRUE' : 'FALSE',
                      style: stl,
                    ),
                    flex: 4,
                  ),
                ],
              ),
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
          child: const Text(
            'close',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
