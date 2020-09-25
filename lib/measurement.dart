import 'dart:io' show Platform;
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

class Measurement {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static AndroidDeviceInfo androidInfo;
  static IosDeviceInfo iosInfo;
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;


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
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      latitude = position.latitude;
      longitude = position.longitude;
    }).catchError((e) {
      print(e);
    });
  }

}
