import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'details.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
//const Home();
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: Text(
          'History',
          style: TextStyle(color: Colors.green),
        ),
        centerTitle: true,
      ),
      body: Center(
        //padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            RaisedButton(
              child: const Text('--TEST--'),
              color: Colors.grey[850],
              elevation: 20.0, //Schatten unter Button
              splashColor: Colors.grey, //Farbe beim Clicken
              textColor: Colors.green,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => DetailView(),
                );
                // Perform some action
              },
            ),
            SizedBox(
              height: 150,
            ),
            Text(
              '2 be continued...',
              style: TextStyle(color: Colors.white, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
