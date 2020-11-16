import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

// ignore: must_be_immutable
class AboutScreen extends StatelessWidget {
  List<String> developers = ["Alexander Moll", "Florian Tillian"];

  // bool isSelected = true;
  static final duration = Duration(
      days: 0, minutes: 0, seconds: 0, milliseconds: 333, microseconds: 0);

  String getNewLineString() {
    StringBuffer sb = new StringBuffer();
    for (String line in developers) {
      sb.write(line + "\n");
    }
    return sb.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0), // here the desired height

        child: AppBar(
          title: Text(
            'About',
            style: TextStyle(
              color: Colors.green,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[850],
        ),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceAround,

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
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              // color: Colors.grey[900],
              child: Image.asset('assets/fh_big.png',
                  colorBlendMode: BlendMode.overlay),
            ),

            Expanded(
              //  SizedBox(
              //width: 390.0,
              child: TypewriterAnimatedTextKit(
                //TypewriterAnimatedTextKit(
                // onTap: () {
                // print("Tap Event");
                // },

                //pause: Duration(milliseconds: 999999999),
                displayFullTextOnTap: false,
                isRepeatingAnimation: false,
                repeatForever: false,
                //displayFullTextOnTap: true,

                text: ["FH-Kärnten WS2020"],
                textStyle: TextStyle(
                    fontSize: 35.0,
                    // fontFamily: "Agne",
                    // fontFamily: "Blobbers",
                    //fontFamily: "Merriweather",
                    //color: Colors.green,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
                //  textAlign: TextAlign.end,

                alignment: AlignmentDirectional.topStart,
                // or Alignment.topLeft
                // alignment: AlignmentDirectional.centerStart // or Alignment.topLeft
                speed: duration,
                pause: duration,
              ),
            ),

            InkWell(
                child: Text("https://www.fh-kaernten.at/",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                        fontSize: 20)),
                onTap: () =>
                    _launchURL() //launch('https://www.fh-kaernten.at/')
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

            Text('\nCredits:\n',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    color: Colors.grey
                    //color: Colors.green

                    )),

            Expanded(
              // width: 300.0,
              child: ColorizeAnimatedTextKit(
                  //  onTap: () {
                  //  print("Tap Event");
                  //},
                  //speed: new Duration(hours:0, minutes:0, seconds:3),
                  repeatForever: true,
                  isRepeatingAnimation: true,
                  speed: duration,
                  pause: duration,
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
                  alignment:
                      AlignmentDirectional.topStart // or Alignment.topLeft
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
                    color: Colors.grey)),
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
