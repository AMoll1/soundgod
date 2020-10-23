import 'dart:io' show Platform;
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:geolocator/geolocator.dart';


class DeviceData {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static AndroidDeviceInfo androidInfo;
  static IosDeviceInfo iosInfo;

  //Position
  static Position position;
  static double latitude;
  static double longitude;

  //Gerät
  static String manufacturer;
  static String model;
  static String osVersion;
  static String sdkVersion;
  static String idDevice;
  static int isPhysicalDevice;


/*
  DeviceData(){
    readDeviceData();
    getLocation();
  }

 */

  static Future<void> readDeviceData() async {
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

  static Future<void> getLocation() async {
    position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      //position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high) {
      latitude = position.latitude;
      longitude = position.longitude;
    }).catchError((e) {
      print(e);
    });
  }

}