import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

  // ignore: must_be_immutable
  class AboutScreen extends StatelessWidget{

  List<String> developers = ["Alexander Moll","Thomas Otti","David Patscheider","Lukas Glantschnig","Florian Tillian"];

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
      appBar: new AppBar(
        title: new Text('About'),

        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.spaceAround
          ,

         // mainAxisAlignment: MainAxisAlignment.start,




          children: <Widget>[



            Text(
                'Project @ FH-Kaernten',
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 40.0,
                  //  color: Colors.green,
                    fontWeight: FontWeight.bold
                )
            ),



            Text(
                '\nCredits:\n',

                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    //color: Colors.green

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

            Text('\nAll rights reserved Ⓒ\n',

                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    //color: Colors.green
                )
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