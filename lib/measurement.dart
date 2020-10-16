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


//Inserting demo data into database
void initDB() async {
  var prod1 = Measurement(soundMin: 15,soundMax: 5,soundAvg: 6,soundDuration: 65);



  /*
  var prod2 = Measurement(
    id: 2,
    title: 'Dress',
    description: 'Summer Dress',
    image: 'dress.png',
    price: 50.0,
  );

  // Insert a product into the database.

   */
  await insertMeasurement(prod1);

 // await insertMeasurement(prod2);
}


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
        "CREATE TABLE measurements(id INTEGER PRIMARY KEY , soundMin REAL, soundMax REAL, soundAvg REAL, soundDuration INTEGER)",
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
       soundMin: maps[i]['soundMin'],
       soundMax: maps[i]['soundMax'],
       soundAvg: maps[i]['soundAvg'],
       soundDuration: maps[i]['soundDuration']
      );
    });
  }


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


