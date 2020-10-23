/*

import 'package:at/measurement.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileIO {


  /*
  static List<Measurement> dummy = [
    Measurement(1, 2, 3, 4),
    Measurement(5, 6, 7, 8),
    Measurement(5, 6, 7, 8),
    Measurement(5, 6, 7, 8),
  ];
*/
  List<Measurement> getMeasurements() //dummy Version toDo correct deserialize
  {
    try {
      List<Measurement> retval = new List<Measurement>();
      Measurement m;
      String readcontent;
      readFile().then((String value) {
        readcontent = value;
      });


      List<String> lm = readcontent.split('{');
      lm.forEach((String meas) {
       // m = new Measurement(0, 0, 0, 0);
        List<String> lines = meas.split('\n');
        lines.forEach((String line) {
          List<String> entry = line.split('\"');
          // if (entry[0] == "name") m.name = entry[3];
          if (entry[0] == "idDevice")
            m.idDevice = entry[3];
          if (entry[0] == "dateTime")
            m.dateTime = DateTime.parse(entry[3]);
          if (entry[0] == "latitude")
            m.latitude = double.parse(entry[3]);
          if (entry[0] == "longitude")
            m.longitude = double.parse(entry[3]);
          if (entry[0] == "soundMin")
            m.soundMin = double.parse(entry[3]);
          if (entry[0] == "soundMax")
            m.soundMax = double.parse(entry[3]);
          if (entry[0] == "soundAvg")
            m.soundAvg = double.parse(entry[3]);
          if (entry[0] == "soundDuration")
            m.soundDuration = int.parse(entry[3]);
          if (entry[0] == "Manufacturer")
            m.manufacturer = entry[3];
          if (entry[0] == "Model")
            m.model = entry[3];
          if (entry[0] == "osVersion")
            m.osVersion = entry[3];
          if (entry[0] == "sdkVersion")
            m.sdkVersion = entry[3];
        });
        // if (m.name != "")
          retval.add(m);
      });

      //read from JSON
      return retval;
    }
    catch (Exception) {
     // return dummy;
    }
  }

  void writeMeasurement(Measurement m) //dummy Version toDo correct serialize
  {
    String entry = "{";

    /*if (m.name.isNotEmpty)
      entry = entry + "\n" + "\"name\" : " + m.name;*/
    if (m.idDevice.isNotEmpty)
      entry = entry + "\n" + "\"idDevice\" : " + m.idDevice;
    if (m.dateTime != null)
      entry = entry + "\n" + "\"dateTime\" : " + m.dateTime.toString();
    if (m.latitude != null)
      entry = entry + "\n" + "\"latitude\" : " + m.latitude.toString();
    if (m.longitude != null)
      entry = entry + "\n" + "\"longitude\" : " + m.longitude.toString();
    if (m.soundMin != null)
      entry = entry + "\n" + "\"soundMin\" : " + m.soundMin.toString();
    if (m.soundMax != null)
      entry = entry + "\n" + "\"soundMax\" : " + m.soundMax.toString();
    if (m.soundAvg != null)
      entry = entry + "\n" + "\"soundAvg\" : " + m.soundAvg.toString();
    if (m.soundDuration != null)
      entry =
          entry + "\n" + "\"soundDuration\" : " + m.soundDuration.toString();
    if (m.manufacturer.isNotEmpty)
      entry = entry + "\n" + "\"Manufacturer\" : " + m.manufacturer;
    if (m.model.isNotEmpty)
      entry = entry + "\n" + "\"Model\" : " + m.model;
    if (m.osVersion.isNotEmpty)
      entry = entry + "\n" + "\"osVersion\" : " + m.osVersion;
    if (m.sdkVersion.isNotEmpty)
      entry = entry + "\n" + "\"sdkVersion\" : " + m.sdkVersion;
    entry = entry + "\n" + "}";

    writeFile(entry);
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/file.txt');
  }

  Future<File> writeFile(String output) async {
    final file = await _localFile;

    // Write the file.
    return file.writeAsString('$output');
  }



  Future<String> readFile() async {
    try {
      final file = await _localFile;
      String test = "manst schaffts das?";
      // Read the file.
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      print(e);
      // If encountering an error, return 0.
      return "";
    }
  }
}
*/