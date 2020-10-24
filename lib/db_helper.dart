import 'package:sqflite/sqflite.dart';
import 'measurement.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'dart:io' as io;
import 'package:path/path.dart';

class DBHelper {
  static Database _db;

  Future<Database> get database async {
    if (_db != null) {
      return _db;
    }
    _db = await initDB();
    return _db;
  }

  initDB() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'measurement.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        // "CREATE TABLE IF NOT EXISTS measurements(id INTEGER PRIMARY KEY , soundMin REAL, soundMax REAL, soundAvg REAL, soundDuration INTEGER, dateTime String)",
        //"CREATE TABLE measurements(id INTEGER PRIMARY KEY , soundMin REAL, soundMax REAL, soundAvg REAL, soundDuration INTEGER, dateTime TEXT, manufacturer TEXT, model TEXT, osVersion TEXT, sdkVersion TEXT, idDevice TEXT, isPhysicalDevice INTEGER NOT NULL CHECK (isPhysicalDevice IN (0,1))",
        "CREATE TABLE measurements(id INTEGER PRIMARY KEY, soundMin REAL, soundMax REAL, soundAvg REAL, soundDuration INTEGER, dateTime TEXT, manufacturer TEXT, model TEXT, osVersion TEXT, sdkVersion TEXT, idDevice TEXT, isPhysicalDevice INTEGER, longitude REAL, latitude REAL, address TEXT)");
  }

  Future<void> insertMeasurement(Measurement measurement) async {
    final db = await database;
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
    final db = await database;
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
          longitude: maps[i]['longitude'],
          latitude: maps[i]['latitude'],
          address: maps[i]['address'],
        );
      },
    );
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
