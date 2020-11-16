import 'dart:math';

import 'package:at/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'details.dart';
import 'measurement.dart';

//List<Measurement> measurements;
final NumberFormat txtFormat = new NumberFormat('###.##');
final DateFormat dateFormat = new DateFormat('HH:mm dd-MM-yyyy');

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  DBHelper dbHelper;
  Future<List<Measurement>> measurement;
  List<String> popupMenuText = ['Delete all'];

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    measurementList();
  }

  measurementList() {
    setState(() {
      measurement = dbHelper.allMeasurements();
    });
  }


  @override
  void dispose() {
    //dbHelper.close();
    super.dispose();
  }

  void appBarAction(String value) async {
    if (value == 'Delete all'){
      await dbHelper.deleteDB();
    }
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HistoryScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0), // here the desired height,
        child: AppBar(
          backgroundColor: Colors.grey[850],
          title: Text(
            'History',
            style: TextStyle(color: Colors.green),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: Colors.green,
              ),
              offset: const Offset(0.0, 30.0),
              color: Colors.grey[700],
              onSelected: appBarAction,
              itemBuilder: (context) {
                return popupMenuText.map((String value) {
                  return PopupMenuItem<String>(
                    textStyle: TextStyle(color: Colors.green, fontSize: 15),
                    value: value,
                    child: Text(value),
                  );
                }).toList();
              },
            )
          ],
        ),
      ),
      body: FutureBuilder(
          future: measurement,
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data == null || snapshot.data.length == 0) {
              return Center(
                  child: Text(
                'No entries available',
                style: TextStyle(color: Colors.green, fontSize: 18),
              ));
            } else {
              return Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: ListView.builder(
                    itemCount: snapshot.data.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "ID",
                                  //measurements[index].name,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      decoration: TextDecoration.underline),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                //  child: Text(snapshot.data[index].dateTime,

                                child: Text(
                                  "Date",
                                  //measurements[index].name,
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      decoration: TextDecoration.underline),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Max",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      decoration: TextDecoration.underline),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Avg",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      decoration: TextDecoration.underline),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Detail",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                      decoration: TextDecoration.underline),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              ),
                            ]);
                      }
                      index -= 1;
                      // print(index);
                      Measurement item = snapshot.data[index];
                      return Dismissible(
                        background: Container(color: Colors.grey[700]),
                        key: Key(snapshot.data[index].toString()),
                        //key: UniqueKey(),
                        onDismissed: (direction) {
                          setState(() {
                            snapshot.data.removeAt(index);
                            dbHelper.deleteMeasurement(item.id);
                          });
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                            "No. ${item.id} deleted",
                            style: TextStyle(color: Colors.green),
                          )));
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text(
                                  snapshot.data[index].id.toString(),
                                  //measurements[index].name,
                                  style: TextStyle(color: Colors.green),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                //  child: Text(snapshot.data[index].dateTime,

                                child: Text(
                                  dateFormat
                                      .format(DateTime.tryParse(
                                          snapshot.data[index].dateTime))
                                      .toString(),
                                  //measurements[index].name,
                                  style: TextStyle(color: Colors.green),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  txtFormat
                                      .format(snapshot.data[index].soundMax)
                                      .toString(),
                                  style: TextStyle(color: Colors.green),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  txtFormat
                                      .format(snapshot.data[index].soundAvg)
                                      .toString(),
                                  style: TextStyle(color: Colors.green),
                                  textAlign: TextAlign.center,
                                  softWrap: false,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: IconButton(
                                    icon: Icon(Icons.info),
                                    color: Colors.lightGreenAccent,
                                    splashColor:
                                        Colors.grey, //Farbe beim Clicken

                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) => DetailView(
                                              measurement: snapshot.data[
                                                  index])); //übergibt aktuelles Measurement an DetailView
                                      // Perform some action
                                    }),
                              )
                            ]),
                      );
                    }),
              );
            }
          }),
    );
  }
}
