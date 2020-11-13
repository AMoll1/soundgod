import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';
import 'package:at/CorrectionCurve.dart';
import 'package:at/Weighting.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DeviceData.dart';
import 'db_helper.dart';
import 'measurement.dart';
import 'package:audio_streamer/audio_streamer.dart';
import 'package:smart_signal_processing/smart_signal_processing.dart';
// import 'dart:developer' as logcat;

final NumberFormat txtFormat = new NumberFormat('###.##');
final int samplingFrequency = 44100;

class HomeMeasurement extends StatefulWidget {
  _HomeMeasurementState createState() => _HomeMeasurementState(
        textColor: TextStyle(
          color: Colors.green,
        ),
      );
}

class _HomeMeasurementState extends State<HomeMeasurement> {
  _HomeMeasurementState({this.textColor});

  static final windowLength = 8192;
  final TextStyle textColor;
  List<int> _currentSamples;
  DateTime _startTime;
  double _actualValue;
  double _minValue;
  double _maxValue;
  double _averageValue;
  double _tempMaxPositive;
  double _tempMinNegative;
  static int _thresholdValue;
  String _selectedWeighting;
  bool _high;
  double _tempAverage;
  bool _threshold;
  double _tempMin;
  List<double> _avgList;
  AudioStreamer _streamer;
  bool _isRecording;
  bool _stopped;
  static DBHelper dbHelper;
  List<double> tempList;
  Float64List realFft;
  Float64List imaginaryFft;
  Weighting _weighting;
  CorrectionCurve _correctionCurve;

  @override
  void initState() {
    getValues();
    _weighting = Weighting.a(samplingFrequency, windowLength);
     _correctionCurve = CorrectionCurve(samplingFrequency, windowLength);
    _isRecording = false;
    _actualValue = 0.0;
    _minValue = double.infinity;
    _maxValue = 0.0;
    _averageValue = 0.0;
    _high = false;
    _tempAverage = 0.0;
    _threshold = false;
    tempList = List<double>();
    _tempMin = 0;
    _stopped = false;
    dbHelper = new DBHelper();
    _streamer = AudioStreamer();
    _avgList = List<double>();
    initWeighting();


    super.initState();
  }

  void initWeighting() {
    switch (_selectedWeighting) {
      case 'A':
        _weighting = Weighting.a(samplingFrequency, windowLength);
        break;
      case 'B':
        _weighting = Weighting.b(samplingFrequency, windowLength);
        break;
      case 'C':
        _weighting = Weighting.c(samplingFrequency, windowLength);
        break;
      case 'D':
        _weighting = Weighting.d(samplingFrequency, windowLength);
        break;
    }
  }

  getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _thresholdValue = prefs.getInt('threshold') ?? 0;
    _selectedWeighting = prefs.getString('weighting') ?? 'A';
    print(_selectedWeighting);
  }

  void onAudio(List<double> buffer) {
    _currentSamples = buffer.map((i) => (i * pow(2, 15)).toInt()).toList();
    calculate(_currentSamples);
    tempList.addAll(buffer);
  }

  void start() async {
    if (_isRecording) return;
    try {
      _streamer.start(onAudio);
      DeviceData.getLocation();
    } catch (error) {
      print(error);
    }
    setState(() {
      _isRecording = true;
    });
  }

  void stop() async {
    if (!_isRecording) return;

    if (_threshold) {
      await dbHelper.insertMeasurement(new Measurement(
          soundMin: this._minValue,
          soundMax: this._maxValue,
          soundAvg: this._averageValue,
          soundDuration: DateTime.now().difference(_startTime).inSeconds,
          dateTime: DateTime.now().toIso8601String(),
          weighting: this._selectedWeighting));
    }
    _stopped = await _streamer.stop();

    setState(() {
      _isRecording = _stopped;
      _threshold = false;
      _currentSamples = null;
      _startTime = null;
      _actualValue = 0.0;
      _minValue = double.infinity;
      _maxValue = 0.0;
      _averageValue = 0.0;
      _tempMin = 0;
      _avgList = [];
    });
  }

  void _changeListening() => !_isRecording ? start() : stop();

/*

  bool _startListening() {
    if (_isRecording) return false;
    if (Platform.isAndroid) {
      //stream = microphone(
        //  sampleRate: 44100,
          //audioSource: AudioSource.MIC,
         // channelConfig: ChannelConfig.CHANNEL_IN_MONO,
         // audioFormat: AUDIO_FORMAT); //16 bit pcm => max.value = 2^16/2

      //listener = stream.listen((samples) => currentSamples = samples);
      listener = stream.listen((samples) {
        // print (samples);
        // samples = samples.where((x) => x > (20.0 * log(thresholdValue.toDouble()) * log10e)).toList();
       // currentSamples = samples.map((e) => e + calibOffset.toInt()).toList();
        currentSamples = samples;
        //print(samples.length); =============================== 3584 values per
        calculate(currentSamples);
      });
    }

    setState(() {
      isRecording = true;
    });

    print("measuring started");

    return true;
  }

*/

  double calcActualValue(List<int> input) {
    return calcDb(input.first.abs().toDouble());
  }

  bool checkThreshold(List<int> input) {
    return input.any((x) => (calcDb(x.toDouble())) > _thresholdValue);
  }

  double calcDb(double input) {
    return 20 * log(input) * log10e;
  }

  double reverseDb(double input) {
    return exp(input / (20 * log10e));
  }

  void calcMax(List<int> input) {
    _tempMaxPositive = calcDb(input.reduce(max).abs().toDouble());
    _tempMinNegative = calcDb(input.reduce(min).abs().toDouble());

    if (_tempMaxPositive > _tempMinNegative) {
      _high = true;
    } else {
      _high = false;
    }

    if (_high && (_tempMaxPositive > _maxValue)) {
      _maxValue = _tempMaxPositive;
    } else if (!_high && (_tempMinNegative > _maxValue)) {
      _maxValue = _tempMinNegative;
    }
  }

  void calcMin(List<int> input) {
    _tempMin = calcDb(input
        .reduce((a, b) => a.abs() <= b.abs() ? a.abs() : b.abs())
        .toDouble());
    if (_tempMin < _minValue) {
      _minValue = _tempMin;
      if (_minValue.isInfinite) _minValue = 0;
    }
  }

  double calcAvg(List<int> input) {
    _tempAverage = calcDb(
        input.reduce((a, b) => a.abs() + b.abs()).toDouble() / input.length);
    _avgList.add(_tempAverage);
    if (_avgList.length >= 188) {
      _tempAverage = _avgList.reduce((a, b) => a + b) / _avgList.length;
      _avgList.clear();
      _avgList.add(_tempAverage);
    }
    return (_avgList.reduce((a, b) => a + b) / _avgList.length);
  }

  void calculate(List<int> input) {
    if (!_threshold) {
      _threshold = checkThreshold(input);

      if (_threshold) {
        print("threshold überschritten = " + _threshold.toString());
        _startTime = DateTime.now();
      }
    }
    if (input.isNotEmpty && _threshold) {
      //_actualValue = calcActualValue(input);
      //calcMax(input);
      //calcMin(input);
      //_averageValue = calcAvg(input);
      calcFft();
    }
    if (mounted) setState(() {});
  }

  void calcFft() {
    if (tempList.length >= windowLength) {
      realFft = Float64List.fromList(tempList.sublist(0, windowLength));
      tempList.removeRange(0, windowLength);
      //logcat.log(currentFFT.toString());
      //debugPrint(currentFFT.toString(),wrapWidth:  10000);
      imaginaryFft = Float64List(windowLength);
      FFT.transform(realFft, imaginaryFft);
      //FFT.transformRadix2(imaginary, currentFFT);
      //imaginary =   imaginary.map((i) => (i/8192)).toList();
      //debugPrint(currentFFT.toString(),wrapWidth:  10000);
      //logcat.log(currentFFT.toString());
      //inverseFft();

      multiply();
    }
  }

  void multiply() {
    Phase a = Phase();
    a.magnitude(realFft, imaginaryFft, true);
    //imaginaryFft = Float64List(windowLength);
    //realFft = Float64List.fromList(realFft.map((e) => e/realFft.length).toList());

    for (int i = 0; i < windowLength; i++) {
      realFft[i] *= _weighting.result[i];
    }

    for (int i = 0; i < windowLength; i++) {
      realFft[i] *= _correctionCurve.result[i];
    }

    inverseFft();
  }

  void inverseFft() {
    if (realFft.length == windowLength) {
      //realFft = Float64List.fromList(tempList.sublist(0,8192));
      //tempList.removeRange(0, 8192);
      // logcat.log(currentFFT.toString());
      //debugPrint(currentFFT.toString(),wrapWidth:  10000);
      //var imaginary = Float64List(8192);
      imaginaryFft = Float64List(windowLength);
      FFT.transform(imaginaryFft, realFft);
      //imaginaryFft = Float64List(windowLength);
      //FFT.transformRadix2(imaginaryFft , realFft);
      //imaginary =   imaginary.map((i) => (i/8192)).toList();
      //debugPrint(currentFFT.toString(),wrapWidth:  10000);
      //logcat.log(currentFFT.toString());
      //print(realFft);
      //print(imaginaryFft);
      realFft =
          Float64List.fromList(realFft.map((e) => e / realFft.length).toList());

      var temp = realFft
          .map((i) => (i.isFinite) ? (i * pow(2, 15)).toInt() : 0)
          .toList();

      _actualValue = calcActualValue(temp);
      calcMax(temp);
      calcMin(temp);
      _averageValue = calcAvg(temp);
    }
  }

  /*
  Future<bool> _stopListening() async {

    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    print("File path:" + appDocPath);


    FileIO fileIO = new FileIO();
    fileIO.writeMeasurement(new Measurement(this.minValue, this.maxValue, this.averageValue, DateTime.now().difference(startTime).inSeconds));
    //if (!isRecording) return false;
   // print("measuring stopped");
   // if (Platform.isAndroid) listener.cancel();
   // if (Platform.isIOS) {
     // controller.stopAudioStream();
      //controller.dispose();
      //controller = new AudioController(CommonFormat.Int16, 44100, 1, true);
   // }

    setState(() {
      isRecording = false;
      threshold = false;
      currentSamples = null;
      startTime = null;
      actualValue = 0.0;
      minValue = double.infinity;
      maxValue = 0.0;
      averageValue = 0.0;
      tempMin = 0;
      avgList = [];
    });
    return true;
  }

  */

  static String formatDuration(Duration d) {
    var seconds = d.inSeconds;
    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;
    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;
    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('$days d');
    }
    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('$hours h');
    }
    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('$minutes m');
    }
    tokens.add('$seconds s');

    return tokens.join(' : ');
  }

  /*

  @override
  void dispose() {
    //thresholdValueController.dispose();
    //FileNameController.dispose();
    //dbHelper.close();
    _streamer.stop();
    super.dispose();
  }
  */

  Color _getBgColor() => (_isRecording) ? Colors.red : Colors.green;

  @override
  Widget build(BuildContext context) {
    // Der widget tree der hier erstellt wird kann jedesmal neu gebaut werden wenn sich eine variable von oben ändert
    return Scaffold(
      // Das Scaffold widget ist der beginn unseres widget-trees ab hier verästeln sich die widgets nach unten

      // --- App Bar at the top ------------------------------------------------
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30.0), // here the desired height
        child: AppBar(
          title: Text(
            'Measurement',
            style: textColor,
          ),
          centerTitle: true,
          backgroundColor: Colors.grey[850],
        ),
      ),
      // --- The Body ----------------------------------------------------------
      // --- Zeilen erstellen --------------------------------------------------
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // --- Zeile 1: Input section ----------------------------------------
          Container(
              // padding: EdgeInsets.all(
              // 3.0), //NICHT MEHR ALS 3.0 SONST KONFLIKT MIT EINGABETASTATUR!

              padding: EdgeInsets.fromLTRB(3, 15, 3, 3),
              color: Colors.grey[800],
              child: Column(
                children: <Widget>[
                  /*   Text(
                    'INPUT',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ), */

/*

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text('Set threshold value:', style: textColor),
                      ),
                      Expanded(
                        child: TextField(
                          controller: thresholdValueController,
                          textAlign: TextAlign.right,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
                            enabledBorder: UnderlineInputBorder(// Warum 2 mal?
                                // borderSide: BorderSide(color: Colors.green),
                                ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            hintText: "$_thresholdValue dB",
                            labelStyle: new TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      RaisedButton(
                        onPressed: () {
                          if (int.tryParse(thresholdValueController.text) !=
                              null) {
                            if (int.tryParse(thresholdValueController.text) <
                                0) {
                              setState(() {
                                //ACHTUNG WICHTIG! Die setState funktion triggert die build funktion des gesamten screens!
                                _thresholdValue = 0;
                              });
                            } else {
                              setState(() {
                                _thresholdValue =
                                    int.tryParse(thresholdValueController.text);
                                // print('Threshold set to ' '$thresholdValue' ' dB');
                              });
                            }
                          } else {
                            setState(() {
                              // default wert wenn zB ein buchstabe eingetippt wird
                              _thresholdValue = 70;
                            });
                          }
                          print('Threshold set to ' '$_thresholdValue' ' dB');
                          thresholdValueController.clear();
                        },
                        child: Text('Set',
                            style: TextStyle(color: Colors.grey[800])),
                        color: Colors.green,
                      ),
                    ],
                  ),


*/

                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Set file name: ', style: textColor),
                      Expanded(
                        child: TextField(
                          controller: FileNameController,
                          textAlign: TextAlign.right,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10.0),
//                            fillColor: Colors.grey[400],
//                            filled: true,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            hintText: recFilename + '.csv',
                            labelStyle: new TextStyle(
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      //Text('meas_1 '),
                      RaisedButton(
                        onPressed: () {
                          setState(() {
                            if (FileNameController.text.isNotEmpty) {
                              if (FileNameController.text.contains('.') ||
                                  FileNameController.text.contains(',') ||
                                  FileNameController.text.contains('#') ||
                                  FileNameController.text.contains('-') ||
                                  FileNameController.text.contains('+')) {
                                //Das muss einfacher gehn um sonderzeichen in der benennung auszuschließen
                                recFilename = 'default';
                              } else {
                                recFilename = FileNameController.text;
                              }
                            } else {
                              recFilename = 'default';
                            }
                          });
                          print('Measurement name set to ' + recFilename);
                          FileNameController.clear();
                        },
                        child: Text(
                          'Set',
                          style: TextStyle(
                            color: Colors.grey[800],
                          ),
                        ),
                        color: Colors.green,
                      ),
                    ],
                  ),

                  */
                ],
              )),

          // --- Zeile 2: Icon button ------------------------------------------
          //IDEE ZUM BUTTON
          //Wenn man auf den IconButton drückt soll darunter in einem TextLabel
          // "RECORDING" bzw. "Bitte drücken Sie!" oder sowas stehen..
          // sodass man weiß, ob gerade aufgenommen wird.
          //vielleicht könnte man direkt unter dem "Start Measurement"-Container
          //noch einen Container einblenden, wo das Frequenzspekturm abgebildet wird? --> Schwierigkeit: next level?
          Container(
            decoration: containerBorder(),
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  _isRecording ? 'RECORDING...' : 'START MEASUREMENT',
                  style: TextStyle(
                    color: _isRecording ? Colors.redAccent : Colors.green,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    border: Border.all(
                        width: 2,
                        color: _isRecording ? Colors.redAccent : Colors.green),
                  ),
                  child: IconButton(
                    onPressed: () {
                      _changeListening();
                      setState(() {});
                    },
                    icon: Icon(Icons.mic,
                        color: _isRecording ? Colors.redAccent : Colors.green),
                    color: Colors.green,
                    iconSize: 100.0,
                  ),
                ),
                Text(
                  'Tap the mic icon to start/stop the measurement',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),

          // --- Zeile 3: Output -----------------------------------------------

          Container(
            padding: EdgeInsets.all(5.0),
            color: Colors.grey[800],
            child: Column(children: <Widget>[
              Text(
                'Result',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  //color: Colors.cyanAccent[700],
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text('Duration:', style: textColor),
                    ),
                    Text(
                        _isRecording && _threshold
                            ? formatDuration(
                                DateTime.now().difference(_startTime))
                            : "0 s",
                        style: textColor),
                    //Text(' s', style: textColor),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text('Average value:', style: textColor),
                    ),
                    Text(
                        _isRecording && _threshold
                            ? txtFormat.format(_averageValue).toString()
                            : "0",
                        style: textColor),
                    Text(
                        (_selectedWeighting == null)
                            ? ' dB'
                            : " dB" + _selectedWeighting,
                        style: textColor),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text('Max value:', style: textColor),
                    ),
                    Text(
                        _isRecording && _threshold
                            ? txtFormat.format(_maxValue).toString()
                            : "0",
                        style: textColor),
                    Text(
                        (_selectedWeighting == null)
                            ? ' dB'
                            : " dB" + _selectedWeighting,
                        style: textColor),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text('Min value:', style: textColor),
                    ),
                    Text(
                        _isRecording && _threshold
                            ? txtFormat.format(_minValue).toString()
                            : "0",
                        style: textColor),
                    Text(
                        (_selectedWeighting == null)
                            ? ' dB'
                            : " dB" + _selectedWeighting,
                        style: textColor),
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Text('Actual value:', style: textColor),
                    ),
                    Text(
                        _isRecording && _threshold
                            ? txtFormat.format(_actualValue).toString()
                            : "0",
                        style: textColor),
                    Text(
                        (_selectedWeighting == null)
                            ? ' dB'
                            : " dB" + _selectedWeighting,
                        style: textColor),
                  ]),
              /*Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: CustomPaint(
                            painter: WavePainter(
                                _currentSamples, _getBgColor(), context))),
                  ]

                  //CustomPaint(painter: WavePainter(currentSamples, _getBgColor(), context))

                  )*/
            ]),
          ),
          // --- Zeile 4: Output -----------------------------------------------
          Expanded(
            child: Container(
              color: Colors.grey[800],
              child: CustomPaint(
                  painter:
                      WavePainter(_currentSamples, _getBgColor(), context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget myWidget() {
    return Container(
      margin: const EdgeInsets.all(30.0),
      padding: const EdgeInsets.all(10.0),
      decoration: containerBorder(),
    );
  }

  BoxDecoration containerBorder() {
    return BoxDecoration(
      color: Colors.grey[800],
      border: Border.all(
        width: 2,
        color: Colors.green,
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  List<int> samples;
  List<Offset> points;
  Color color;
  BuildContext context;
  Size size;

  final int absMax = 120000; //32767;

  //   (AUDIO_FORMAT == AudioFormat.ENCODING_PCM_8BIT) ? 127 /*+ _HomeMeasurementState.calibOffset.toInt()*/ : 32767 /*+ _HomeMeasurementState.calibOffset.toInt()*/;

  WavePainter(this.samples, this.color, this.context);

  @override
  void paint(Canvas canvas, Size size) {
    this.size = context.size;
    size = this.size;

    Paint paint = new Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    points = toPoints(samples);
    Path path = new Path();
    path.addPolygon(points, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldPainting) => true;

  List<Offset> toPoints(List<int> samples) {
    List<Offset> points = [];
    if (samples == null)
      samples =
          // List<int>.filled(size.width.toInt(), (0.5 * size.height).toInt());
          List<int>.filled(size.width.toInt(), (0.5 * size.height).toInt());

    for (int i = 0; i < min(size.width, samples.length).toInt(); i++) {
      points.add(
          new Offset(i.toDouble(), project(samples[i], absMax, size.height)));
    }
    return points;
  }

  double project(int val, int max, double height) {
    double waveHeight =
        (max == 0) ? val.toDouble() : (val / max) * 0.5 * height;
    // return waveHeight + 0.5 * height;
    return waveHeight +
        0.15 * height; //offset geändert kann man vl verbessern !!! 25 vorher
  }
}

// --- Backup code ----------------------------------------------------------
/*child: Image(),*/

/*CircleAvatar(
backgroundImage: AssetImage('asstes/thum.jpg'),
radius: 40.0,
),*/

/*Divider(
height: 60.0,
)*/

/*body: Center()*/

/*child: Icon(
          Icons.speaker,
          color: Colors.cyanAccent[700],
        ),'*/

/*child: Text(
          'Threshold value:',
          style: TextStyle(
            fontSize: 12.0,
            //fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.grey[800],
          ),
        ),*/

/*SizedBox(height: 30.0),*/

/*
floatingActionButton: FloatingActionButton(
child: Text('Start Measurement'),
backgroundColor: Colors.cyanAccent[700],
),*/

/*
child: RaisedButton.icon(
onPressed: () {
print('Measurement started');
},
icon: Icon(
Icons.adjust
),
label: Text('Start measurement'),
color: Colors.cyanAccent[700],
),*/

/*
child: IconButton(
onPressed: () {
print('Measurement started');
},
icon: Icon(Icons.adjust),
color: Colors.cyanAccent[700],
iconSize: 50.0,
)*/

/*body: Container(
padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
margin: EdgeInsets.all(0),
color: Colors.grey[700],
child: Text('Hello'),
),*/

/*body: Padding(
padding: EdgeInsets.all(10),
child: Text('Hello'),
),*/

/*      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: <Widget>[
          Text('Set threshold value:'),

          RaisedButton(
            onPressed: () {
              print('Threshold set');
            },
            child: Text('Set'),
            color: Colors.cyanAccent[700],
          ),
        ],
      ),*/
