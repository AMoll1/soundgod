import 'package:shared_preferences/shared_preferences.dart';

import 'device_data.dart';

class Measurement {
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
  });

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
}
