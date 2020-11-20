import 'dart:io' show Platform;
import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class DeviceData {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static AndroidDeviceInfo androidInfo;
  static IosDeviceInfo iosInfo;

  //Position
  static Position position;
  static double latitude;
  static double longitude;
  static String address;

  //Gerät
  static String manufacturer;
  static String model;
  static String osVersion;
  static String sdkVersion;
  static String idDevice;
  static int isPhysicalDevice;

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
      }
    } on PlatformException {
      print("platform error");
    }
  }

  static Future<void> getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationServiceEnabled &&
        (permission != LocationPermission.deniedForever ||
            LocationPermission.denied != permission)) {
      // todo: noch einmal kontrollieren
      //if (isLocationServiceEnabled) {
      position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best)
          .then((Position position) async {
        //position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high) {
        latitude = position.latitude;
        longitude = position.longitude;
        //get the address
        final coordinates = new Coordinates(latitude, longitude);
        var addresses =
            await Geocoder.local.findAddressesFromCoordinates(coordinates);
        address = addresses.first.addressLine;
      }).catchError((e) {
        print(e);
      });
    }
  }
}
