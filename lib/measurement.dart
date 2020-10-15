import 'dart:io' show Platform;
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';

import 'history.dart';


void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final Future<Database> database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'measurement.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE measurements(id INTEGER PRIMARY KEY AUTOINCREMENT, soundMin REAL, soundMax REAL, soundAvg REAL, SoundDuration INTEGER)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  Future<void> insertMeasurement(Measurement measurement) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'measurements',
      measurement.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Measurement>> measurements() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('measurements');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Measurement(
        maps[i]['soundMin'],
        maps[i]['soundMax'],
        maps[i]['soundAvg'],
        maps[i]['soundDuration']
      );
    });
  }


}



class Measurement {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static AndroidDeviceInfo androidInfo;
  static IosDeviceInfo iosInfo;
  static Position position;


  String idDevice = ""; //get Info
  DateTime dateTime = DateTime.now();
  double latitude; // get Info
  double longitude;
  double soundMin;
  double soundMax;
  double soundAvg;
  int soundDuration;
  String manufacturer = ""; //
  String model = ""; //
  String osVersion = ""; //
  String sdkVersion = "";

  Measurement(this.soundMin, this.soundMax, this.soundAvg, this.soundDuration) {
    readDeviceData();
    //print("Running on " + androidInfo.model);  // e.g. "Moto G (4)"
    getLocation();
  }


  Map<String, dynamic> toMap() {
    return {
      'soundMin': soundMin,
      'soundMax': soundMax,
      'soundAvg': soundAvg,
      'soundDuration': soundDuration,
    };
  }







  Future<void> readDeviceData() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        model = androidInfo.model;
        manufacturer = androidInfo.manufacturer;
        //osVersion = "";
        idDevice = androidInfo.androidId;
        sdkVersion = androidInfo.version.sdkInt.toString();
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        model = iosInfo.model;
        manufacturer = iosInfo.name;
        osVersion = iosInfo.systemVersion;
        idDevice = iosInfo.utsname.version;
        //sdkVersion = "";
      }
    } on PlatformException {
      print("platform error");
    }
  }

  Future<void> getLocation() async {
      position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.best).then((Position position) {
      //position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high) {
      latitude = position.latitude;
      longitude = position.longitude;
    }).catchError((e) {
      print(e);
    });
  }

}


