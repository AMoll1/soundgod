import 'package:at/measurement.dart';
import 'dart:async';
import 'dart:io';

class FileIO
{
  static List<Measurement> dummy = [Measurement("Test1",1,2,3,4), Measurement("Nochmalwas",5,6,7,8)];
  static List<Measurement> getMeasurements() //dummy Version toDo correct deserialize
  {

    try {
      List<Measurement> retval = new List<Measurement>();
      Measurement m;
      String readcontent = "";
      new File('file.txt').readAsString().then((String contents) {
        print(contents);
        readcontent = contents;
      });
      List<String> lm = readcontent.split('{');
      lm.forEach((String meas) {
        m = new Measurement("",0,0,0,0);
        List<String> lines = meas.split('\n');
        lines.forEach((String line) {
          List<String> entry = line.split('\"');
          if (entry[0] == "name")
            m.name = entry[3];
          if (entry[0] == "idDevice")
            m.idDevice = entry[3];
          if (entry[0] == "dateTime")
            m.dateTime = DateTime.parse(entry[3]);
          if (entry[0] == "latitude")
            m.latitude = int.parse(entry[3]);
          if (entry[0] == "longitude")
            m.longitude = int.parse(entry[3]);
          if (entry[0] == "soundMin")
            m.soundMin = int.parse(entry[3]);
          if (entry[0] == "soundMax")
            m.soundMax = int.parse(entry[3]);
          if (entry[0] == "soundAvg")
            m.soundAvg = int.parse(entry[3]);
          if (entry[0] == "soundDuration")
            m.soundDuration = int.parse(entry[3]);
          if (entry[0] == "Manufacturer")
            m.Manufacturer = entry[3];
          if (entry[0] == "Model")
            m.Model = entry[3];
          if (entry[0] == "osVersion")
            m.osVersion = entry[3];
          if (entry[0] == "sdkVersion")
            m.sdkVersion = entry[3];
        });
        if (m.name != "")
          retval.add(m);
      });

      //read from JSON
      return retval;
    }
    catch(Exception)
    {
      return dummy;
    }
  }


  static void writeMeasurement(Measurement m)//dummy Version toDo correct serialize
  {

    try {
      var file = new File('file.txt');
      var tw = file.openWrite();

      tw.writeln("{");
      if (m.name.isNotEmpty)
        tw.writeln("\"name\" : " + m.name);
      if (m.idDevice.isNotEmpty)
        tw.writeln("\"idDevice\" : " + m.idDevice);
      if (m.dateTime != null)
        tw.writeln("\"dateTime\" : " + m.dateTime.toString());
      if (m.latitude != null)
        tw.writeln("\"latitude\" : " + m.latitude.toString());
      if (m.longitude != null)
        tw.writeln("\"longitude\" : " + m.longitude.toString());
      if (m.soundMin != null)
        tw.writeln("\"soundMin\" : " + m.soundMin.toString());
      if (m.soundMax != null)
        tw.writeln("\"soundMax\" : " + m.soundMax.toString());
      if (m.soundAvg != null)
        tw.writeln("\"soundAvg\" : " + m.soundAvg.toString());
      if (m.soundDuration != null)
        tw.writeln("\"soundDuration\" : " + m.soundDuration.toString());
      if (m.Manufacturer.isNotEmpty)
        tw.writeln("\"Manufacturer\" : " + m.Manufacturer);
      if (m.Model.isNotEmpty)
        tw.writeln("\"Model\" : " + m.Model);
      if (m.osVersion.isNotEmpty)
        tw.writeln("\"osVersion\" : " + m.osVersion);
      if (m.sdkVersion.isNotEmpty)
        tw.writeln("\"sdkVersion\" : " + m.sdkVersion);
      tw.writeln("}");


      // Close the IOSink to free system resources.
      tw.close();
    }
    catch(Exception)
    {
      dummy.add(m);
    }
  }


}