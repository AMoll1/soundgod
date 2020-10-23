import 'package:at/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0), // here the desired height,
        child: AppBar(
          backgroundColor: Colors.grey[850],
          title: Text(
            'History',
            style: TextStyle(color: Colors.green),
          ),
          centerTitle: true,
        ),
      ),

      /*

      body: Center(
        //padding: const EdgeInsets.only(top: 100.0),
          child:
          Center(
            child: ListView.builder(
                itemCount: measurements.length,
                itemBuilder: (context, index){
                  return Row
                    (
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          flex:1,
                          child: Text(
                            index.toString(), // Nummerierung
                            //measurements[index].name,
                            style: TextStyle(color: Colors.green),textAlign: TextAlign.center,),
                        ),
                        Expanded(
                          flex:2,
                          child: Text(measurements[index].dateTime.toString(),
                            style: TextStyle(color: Colors.green),textAlign: TextAlign.center,),
                        ),
                        Expanded(
                          flex:1,
                          child: IconButton(
                              icon: Icon(Icons.info),
                              color: Colors.lightGreenAccent,
                              splashColor: Colors.grey, //Farbe beim Clicken

                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => DetailView(measurement: measurements[index])); //übergibt aktuelles Measurement an DetailView
                                // Perform some action
                              }),
                        )
                      ]);
                }
            ),
          )
      ),


      */

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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                flex: 1,
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
                                flex: 1,
                                child: Text(
                                  "MaxValue",
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
                                flex: 1,
                                child: Text(
                                  "AvgValue",
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
                                flex: 1,
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
                        key: Key(snapshot.data[index].toString()),
                        //key: UniqueKey(),
                        onDismissed: (direction) {
                          snapshot.data.removeAt(index);
                          dbHelper.deleteMeasurement(item.id);
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                flex: 1,
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
                                flex: 1,
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
                                flex: 1,
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
                                flex: 1,
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
