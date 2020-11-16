import 'package:shared_preferences/shared_preferences.dart';

class CorrectionCurve {
  int calib1;
  int calib2;
  int calib3;
  int calib4;
  int calib5;
  double _temp;
  List<double> result;

  CorrectionCurve(int samplingFrequency, int length) {
    this.result = List(length);
    double factor = samplingFrequency / length;
    getValues().whenComplete(() => init(factor, length));
  }

  void init(double factor, int length) {
    for (int i = 0; i < length; i++) {
      _temp = ((i - ((length / 2))) * factor).abs();
      if (_temp >= 7000) {
        result[i] = 1 + calib5 / 100;
      } else if (_temp > 3520) {
        result[i] = 1 + calib4 / 100;
      } else if (_temp > 880) {
        result[i] = 1 + calib3 / 100;
      } else if (_temp > 440) {
        result[i] = 1 + calib2 / 100;
      } else {
        result[i] = 1 + calib1 / 100;
      }
    }
  }

  Future getValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    calib1 = prefs.getInt('calib1') ?? 0;
    calib2 = prefs.getInt('calib2') ?? 0;
    calib3 = prefs.getInt('calib3') ?? 0;
    calib4 = prefs.getInt('calib4') ?? 0;
    calib5 = prefs.getInt('calib5') ?? 0;
  }
}
