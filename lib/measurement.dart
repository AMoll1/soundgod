import 'dart:io' show Platform;
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';

class Measurement {


  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
 static AndroidDeviceInfo androidInfo;
 static IosDeviceInfo iosInfo;

  String name = "";
  String idDevice = ""; //get Info
  DateTime dateTime = DateTime.now();
  int latitude; // get Info
  int longitude;
  int soundMin;
  int soundMax;
  int soundAvg;
  int soundDuration;
  String manufacturer = "";//
  String model = "";//
  String osVersion = "";//
  String sdkVersion = "";


  Measurement(this.name, this.soundMin, this.soundMax, this.soundAvg,
      this.soundDuration) {
    readDeviceData();
    //print("Running on " + androidInfo.model);  // e.g. "Moto G (4)"
  }

  Future<void> readDeviceData() async {

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        model = androidInfo.model;
        manufacturer = androidInfo.manufacturer;
        osVersion = androidInfo.version.toString();
        idDevice = androidInfo.androidId;
        sdkVersion ="";
        osVersion ="";

      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo =  await deviceInfoPlugin.iosInfo;
        model = iosInfo.model;
        manufacturer = "Apple";
        osVersion = iosInfo.systemVersion;
        idDevice = "";
        sdkVersion = "";
        osVersion ="";
      }

    } on PlatformException {
    print("platform error");
    }
  }
}