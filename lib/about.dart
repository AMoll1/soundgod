import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

/*
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'About Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        brightness:Brightness.dark,

      ),
      home: MyHomePage(title: 'About Demo'),
    );
  }
}

class AboutScreen extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;




  @override
  _MyHomePageState createState() => _MyHomePageState();
}
*/

//class _MyHomePageState extends State<MyHomePage> {

  // ignore: must_be_immutable
  class AboutScreen extends StatelessWidget{
  List<String> developers = ["Alexander Moll","Thomas Otti","David Patscheider","Lukas Glantschnig","Florian Tillian"];
  String dev = "Alexander Moll Thomas Otti David Patscheider Lukas Glantschnig Florian Tillian";

  String getNewLineString() {
    StringBuffer sb = new StringBuffer();
    for (String line in developers) {
      sb.write(line + "\n");
    }
    return sb.toString();
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
/*      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),*/
      backgroundColor: Colors.grey[800],
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[



            Text(
                'Project @ FH-Kaernten',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold
                )
            ),



            Text(
                '\nmade by:\n',

                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                )
            ),



            Text(
              getNewLineString(),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 20,

              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green
                // backgroundColor: Colors.black
              ),

            ),

            InkWell(

                child: Text("https://www.fh-kaernten.at/", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue)),
                onTap: () => _launchURL()//launch('https://www.fh-kaernten.at/')

            ),



          ],
        ),
      ),

    );
  }

  _launchURL() async {
    const url = 'https://www.fh-kaernten.at/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }




}