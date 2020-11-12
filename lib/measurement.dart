import 'package:shared_preferences/shared_preferences.dart';

import 'DeviceData.dart';

/*
final database = db();

Future<Database> db() async {
  return openDatabase(
    join(await getDatabasesPath(), 'measurement.db'),
    onCreate: (db, version) {
      return db.execute(
        // "CREATE TABLE IF NOT EXISTS measurements(id INTEGER PRIMARY KEY , soundMin REAL, soundMax REAL, soundAvg REAL, soundDuration INTEGER, dateTime String)",
        //"CREATE TABLE measurements(id INTEGER PRIMARY KEY , soundMin REAL, soundMax REAL, soundAvg REAL, soundDuration INTEGER, dateTime TEXT, manufacturer TEXT, model TEXT, osVersion TEXT, sdkVersion TEXT, idDevice TEXT, isPhysicalDevice INTEGER NOT NULL CHECK (isPhysicalDevice IN (0,1))",
        "CREATE TABLE measurements(id INTEGER PRIMARY KEY AUTOINCREMENT, soundMin REAL, soundMax REAL, soundAvg REAL, soundDuration INTEGER, dateTime TEXT, manufacturer TEXT, model TEXT, osVersion TEXT, sdkVersion TEXT, idDevice TEXT, isPhysicalDevice INTEGER )",
      );
    },
    // Version provides path to perform database upgrades and downgrades.
    version: 1,
  );
}

Future<void> insertMeasurement(Measurement measurement) async {
  final Database db = await database;
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
  final Database db = await database;
  final List<Map<String, dynamic>> maps = await db.query("measurements");
  return List.generate(
    maps.length,
    (i) {
      return Measurement.fromData(
        soundMin: maps[i]['soundMin'],
        soundMax: maps[i]['soundMax'],
        soundAvg: maps[i]['soundAvg'],
        soundDuration: maps[i]['soundDuration'],
        dateTime: maps[i]['dateTime'],
        id: maps[i]['id'],
        manufacturer: maps[i]['manufacturer'],
        model: maps[i]['model'],
        osVersion: maps[i]['osVersion'],
        sdkVersion: maps[i]['sdkVersion'],
        idDevice: maps[i]['idDevice'],
        isPhysicalDevice: maps[i]['isPhysicalDevice'],
      );
    },
  );
}
*/
class Measurement {
  //static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  //static final DeviceData deviceData = DeviceData();

  //AndroidDeviceInfo androidInfo;
  // IosDeviceInfo iosInfo;

  //Position
  //Position position;
  double latitude;
  double longitude;
  String address;

  //Messung
  final double soundMin;
  final double soundMax;
  final double soundAvg;
  final int soundDuration;
  final String dateTime;
  int id;
  String weighting;

  //Gerät
  String manufacturer;
  String model;
  String osVersion;
  String sdkVersion;
  String idDevice;
  int isPhysicalDevice;

  Measurement(
      {this.soundMin,
      this.soundMax,
      this.soundAvg,
      this.soundDuration,
      this.dateTime,
      this.weighting}) {
    this.manufacturer = DeviceData.manufacturer;
    this.osVersion = DeviceData.osVersion;
    this.sdkVersion = DeviceData.sdkVersion;
    this.idDevice = DeviceData.idDevice;
    this.isPhysicalDevice = DeviceData.isPhysicalDevice;
    this.model = DeviceData.model;
    this.latitude = DeviceData.latitude;
    this.longitude = DeviceData.longitude;
    this.address = DeviceData.address;
    //this.weighting.toString();
  }

  Measurement.fromData({
    this.soundMin,
    this.soundMax,
    this.soundAvg,
    this.soundDuration,
    this.dateTime,
    this.id,
    this.manufacturer,
    this.model,
    this.osVersion,
    this.sdkVersion,
    this.idDevice,
    this.isPhysicalDevice,
    this.latitude,
    this.longitude,
    this.address,
    this.weighting,
  }) {}

  Map<String, dynamic> toMap() {
    return {
      'soundMin': soundMin,
      'soundMax': soundMax,
      'soundAvg': soundAvg,
      'soundDuration': soundDuration,
      'dateTime': dateTime,
      'manufacturer': manufacturer,
      'model': model,
      'osVersion': osVersion,
      'sdkVersion': sdkVersion,
      'idDevice': idDevice,
      'isPhysicalDevice': isPhysicalDevice,
      'longitude': longitude,
      'latitude': latitude,
      'address': address,
      'weighting': weighting,
    };
  }

  @override
  String toString() {
    return 'Measurement("soundMin": ${this.soundMin}, "soundMax": ${this.soundMax}, "soundAvg": ${this.soundAvg}, "soundDuration":${this.soundDuration}, "dateTime":${this.dateTime});';
  }

/*
  Future<void> readDeviceData() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        model = androidInfo.model;
        manufacturer = androidInfo.manufacturer;
        idDevice = androidInfo.androidId;
        sdkVersion = androidInfo.version.sdkInt.toString();
        isPhysicalDevice = androidInfo.isPhysicalDevice ? 1 : 0;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        model = iosInfo.utsname.machine;
        manufacturer = iosInfo.name;
        osVersion = iosInfo.systemVersion;
        idDevice = iosInfo.utsname.version;
        isPhysicalDevice = iosInfo.isPhysicalDevice ? 1 : 0;

        //sdkVersion = "";
      }
    } on PlatformException {
      print("platform error");
    }
  }

  Future<void> getLocation() async {
    position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      //position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high) {
      latitude = position.latitude;
      longitude = position.longitude;
    }).catchError((e) {
      print(e);
    });
  }

  */

}
