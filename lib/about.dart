import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';


  // ignore: must_be_immutable
  class AboutScreen extends StatelessWidget{

  List<String> developers = ["Alexander Moll","Thomas Otti","David Patscheider","Lukas Glantschnig","Florian Tillian"];

  bool isSelected = true;

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
      backgroundColor: Colors.grey[800],
/*      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),*/

/*
      appBar: new AppBar(
        title: new Text('About'),

        centerTitle: true,
      ),
      */
        appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0), // here the desired height

    child:AppBar(
    title: Text(
    'About',
    //style: textColor,

    ),
    centerTitle: true,

    backgroundColor: Colors.grey[850],
    ),
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

/*

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
*/
            //Image.asset('assets/fh_big.png',colorBlendMode: BlendMode.colorBurn),

            Container(
              padding: EdgeInsets.symmetric(vertical: 40.0,horizontal: 20.0),
             // color: Colors.grey[900],
              child: Image.asset('assets/fh_big.png',colorBlendMode: BlendMode.overlay),
            ),


          Expanded(
          //  SizedBox(
              //width: 390.0,
             child: TypewriterAnimatedTextKit(
                //TypewriterAnimatedTextKit(
                // onTap: () {
                // print("Tap Event");
                // },
                 speed: Duration(milliseconds: 3000),
                 pause: Duration(milliseconds: 0),
                  totalRepeatCount: 0,
                  isRepeatingAnimation: false,
                  //displayFullTextOnTap: true,

                  text: ["FH-Kärnten SS2020"],
                  textStyle: TextStyle(
                      fontSize: 35.0,
                     // fontFamily: "Agne",
                     // fontFamily: "Blobbers",
                      //fontFamily: "Merriweather",
                      //color: Colors.green,
                        color: Colors.green,
                      fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.start,
               //  textAlign: TextAlign.end,

                  alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                // alignment: AlignmentDirectional.centerStart // or Alignment.topLeft
              ),

      ),


            InkWell(
                child: Text("https://www.fh-kaernten.at/", style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue, fontSize: 20)),
                onTap: () => _launchURL()//launch('https://www.fh-kaernten.at/')
            ),




/*
            Text(
              'Greetings, planet!',
              style: TextStyle(
                  fontSize: 40,
                  foreground: Paint()
                    ..shader = ui.Gradient.linear(
                      const Offset(0, 20),
                      const Offset(150, 20),
                      <Color>[
                        Colors.red,
                        Colors.yellow,
                      ],
                    )
              ),
            ),

*/






        /*

        Text(
              'Greetings, planet!',
              style: TextStyle(
                fontSize: 40,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 6
                  ..color = Colors.blue[700],
              ),
            ),
            // Solid text as fill.
            Text(
              'Greetings, planet!',
              style: TextStyle(
                fontSize: 40,
                color: Colors.grey[300],
              ),
            ),



*/

        /*
            AnimatedDefaultTextStyle(
                style: isSelected ? TextStyle(fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold)

                : TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w100
                ),
                duration: const Duration(milliseconds: 200),
                child: Text ("test")),




*/



         Text(
                '\nCredits:\n',

                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.grey
                  //color: Colors.green


                )
            ),

     Expanded(
         // width: 300.0,
          child: ColorizeAnimatedTextKit(
            //  onTap: () {
              //  print("Tap Event");
              //},
              //speed: new Duration(hours:0, minutes:0, seconds:3),
              isRepeatingAnimation: true,
              speed: Duration(milliseconds: 1000),
              pause: Duration(milliseconds: 300),
              totalRepeatCount:  2147483647,
              text: developers,

              textStyle: TextStyle(
                  fontSize: 30.0,
                  fontFamily: "Horizon",
                fontWeight: FontWeight.bold,
              ),
              colors: [
              //  Colors.purple,
              //  Colors.blue,
               // Colors.yellow,
              //  Colors.red,




                Colors.green,
                Colors.black,
                Colors.purple,
               Colors.white,
                Colors.grey,
              ],
              textAlign: TextAlign.center,
              alignment: AlignmentDirectional.topStart // or Alignment.topLeft
          ),
        ),


            /*

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

*/

            Text('\nAll rights reserved Ⓒ\n',

                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    //color: Colors.green
                  color: Colors.grey
                )
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