import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MaterialApp(
  home: DetailView(),
));

class DetailView extends StatefulWidget {
  @override
  _DetailViewState createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  String a = 'jhghjg';

  static DateTime now = new DateTime.now();
  String formDate = DateFormat('EEE d MMM kk:mm:ss').format(now);

  TextStyle stl = new TextStyle(
    fontSize: 20.0,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        //centerTitle: true,
        backgroundColor: Colors.green,
        title: Text('Measurement 1'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 10.0),
              Card(
                color: Colors.green,
                child: Text(
                  'Measurement Data',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'ID Device: $a',
                style: stl,
              ),
              SizedBox(height: 5.0),
              Text(
                'DateTime: $formDate',
                style: stl,
              ),
              SizedBox(height: 5.0),
              Text(
                'Latitude: $a',
                style: stl,
              ),
              SizedBox(height: 5.0),
              Text(
                'Longitude: $a',
                style: stl,
              ),
              SizedBox(height: 5.0),
              Text(
                'Sound min: $a',
                style: stl,
              ),
              SizedBox(height: 5.0),
              Text(
                'Sound max: $a',
                style: stl,
              ),
              SizedBox(height: 5.0),
              Text(
                'Sound avg: $a',
                style: stl,
              ),
              SizedBox(height: 5.0),
              Text(
                'Sound duration: $a',
                style: stl,
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                color: Colors.green,
                child: Text(
                  'Device Data',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Manufacturer: $a',
                style: stl,
              ),
              SizedBox(height: 5.0),
              Text(
                'Model: $a',
                style: stl,
              ),
              SizedBox(height: 5.0),
              Text(
                'os Version: $a',
                style: stl,
              ),
              SizedBox(height: 5.0),
              Text(
                'sdk Version: $a',
                style: stl,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
