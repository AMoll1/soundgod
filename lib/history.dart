import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'FileIO.dart';
import 'details.dart';
import 'measurement.dart';

List<Measurement> measurements;

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //FileIO.writeMeasurement(Measurement("Name1"));
    //FileIO.writeMeasurement(Measurement("Test"));
  //  FileIO fileIO = new FileIO();
   // measurements =  fileIO.getMeasurements();
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
          future: allMeasurements(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container(


                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context,int index){
                      return Row
                        (
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Expanded(
                              flex:1,
                              child: Text(snapshot.data[index].soundMax.toString(),
                                //measurements[index].name,
                                style: TextStyle(color: Colors.green),textAlign: TextAlign.center,),
                            ),
                            Expanded(
                              flex:1,
                              child: Text(snapshot.data[index].soundMin.toString(),
                                //measurements[index].name,
                                style: TextStyle(color: Colors.green),textAlign: TextAlign.center,),
                            ),
                            Expanded(
                              flex:2,
                              child: Text(snapshot.data[index].soundAvg.toString(),
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
                                        builder: (context) => DetailView(measurement: snapshot.data[index])); //übergibt aktuelles Measurement an DetailView
                                    // Perform some action
                                  }),
                            )
                          ]);
                    }
                ),
              );
            }
          }),


















    );
  }
}
