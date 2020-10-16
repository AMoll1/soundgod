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


final database = db();

Future<Database> db() async {
  return openDatabase(
    join(await getDatabasesPath(), 'measurement.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE IF NOT EXISTS measurements(id INTEGER PRIMARY KEY , soundMin REAL, soundMax REAL, soundAvg REAL, soundDuration INTEGER)",
      );
    },
    // Version provides path to perform database upgrades and downgrades.
    version: 1,
  );
}


Future<void> insertMeasurement(Measurement measurement) async {
  // Get a reference to the database.
  final Database db = await database;

  // Insert the Product into the correct table. Also specify the
  // `conflictAlgorithm`. In this case, if the same product is inserted
  // multiple times, it replaces the previous data.
  await db.insert(
    "measurements",
    measurement.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}



Future<void> deleteMeasurement(int id) async {
  // Get a reference to the database.
  final db = await database;

  // Remove the Product from the database.
  await db.delete(
    "measurements",
    // Use a `where` clause to delete a specific product.
    where: "id = ?",
    // Pass the Products's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );
}


/* TODO sdgfdfgdfsg
Future<void> updateMeasurement(Measurement measurement) async {
  // Get a reference to the database.
  final db = await database;

  // Update the given Product.
  await db.update(
    "measurements",
    measurement.toMap(),
    // Ensure that the Product has a matching id.
    where: "id = ?",
    // Pass the Products's id as a whereArg to prevent SQL injection.
    whereArgs: [measurement.id],
  );
}

*/



Future<List<Measurement>> allMeasurements() async {
  // Get a reference to the database.
  final Database db = await database;

  // Query the table for all The Products.
  final List<Map<String, dynamic>> maps = await db.query("measurements");

  // Convert the List<Map<String, dynamic> into a List<Product>.
  return List.generate(
    maps.length,
        (i) {
      return Measurement(
          soundMin: maps[i]['soundMin'],
          soundMax: maps[i]['soundMax'],
          soundAvg: maps[i]['soundAvg'],
          soundDuration: maps[i]['soundDuration'])

      ;

    },


  );

}







class Measurement {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static AndroidDeviceInfo androidInfo;
  static IosDeviceInfo iosInfo;
  static Position position;
  //final int id;

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

  Measurement({this.soundMin, this.soundMax, this.soundAvg, this.soundDuration}) {
    readDeviceData();
    //print("Running on " + androidInfo.model);  // e.g. "Moto G (4)"
   // getLocation(); todo
  }


  Map<String, dynamic> toMap() {
    return {
      'soundMin': soundMin,
      'soundMax': soundMax,
      'soundAvg': soundAvg,
      'soundDuration': soundDuration,
    };
  }




  @override
  String toString() {
    return 'Measurement("soundMin": ${this.soundMin}, "soundMax": ${this.soundMax}, "soundAvg": ${this.soundAvg}, "soundDuration":${this.soundDuration});';
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


