import 'package:device_info/device_info.dart';

class Measurement
{
  String name = "";
  String idDevice = ""; //get Info
  DateTime dateTime = DateTime.now();
  int latitude; // get Info
  int longitude;
  int soundMin;
  int soundMax;
  int soundAvg;
  int soundDuration;
  String Manufacturer  = "" ; //get Info
  String Model  = "";
  String osVersion = "";
  String sdkVersion = "";

  Measurement(this.name, this.soundMin,this.soundMax, this.soundAvg, this.soundDuration);






}