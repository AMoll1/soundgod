import 'dart:math';

class Weighting {
  static final int factor1 = 148693636; //12194²
  static final double factor2 = 424.36; //20.6²

  List<double> result;

  Weighting.a(int samplingFrequency, int length) {
    //Fs*(0:(L/2))/L;
    this.result = List();
    //List<double> freq = List(length ~/ 2);
    List<double> freq = List(length);
    double factor = samplingFrequency / length;
    double factor3 = 11599.29; //107.7²
    double factor4 = 544496.41; //737.9²

    //Offset -> Wert bei 1000Hz
    var offset = (factor1 * pow(1000, 4)) /
        ((pow(1000, 2) + factor2) *
            (pow(1000, 2) + factor1) *
            sqrt((pow(1000, 2) + factor3) * (pow(1000, 2) + factor4)));

    for (int i = 0; i < length; i++) {
      freq[i] = (i-((length/2))) * factor;
    }

    // hier wird A(f) berechnet
    for (var x in freq) {
      var temp = (factor1 * pow(x, 4)) /
          ((pow(x, 2) + factor2) *
              (pow(x, 2) + factor1) *
              sqrt((pow(x, 2) + factor3) * (pow(x, 2) + factor4)));


      this.result.add(1+temp-0.7943);
      //print("Frequenz="+x.toString());
      //print(offset);
      //print(1+temp-0.7943);
      print(temp);

      //0.7943


      //Brauchen wir nicht? da kein dB?
      //this.result.add(20 * log(temp) * log10e - 20 * log(offset) * log10e);
      //Returns negative infinity if x is equal to zero. Returns NaN if x is NaN or less than zero.
    }
  }

  Weighting.b(int samplingFrequency, int length) {
    //Fs*(0:(L/2))/L;
    this.result = List();
    List<double> freq = List(length ~/ 2);
    //List<double> freq = List(length);
    double factor = samplingFrequency / length;
    double factor3 = 25122.25; //158.5²
    var offset = (factor1 * pow(1000, 3)) /
        ((pow(1000, 2) + factor2) *
            (pow(1000, 2) + factor1) *
            sqrt(pow(1000, 2) + factor3));

    for (int i = 0; i < length / 2; i++) {
      freq[i] = i * factor;
    }

    // hier wird A(f) berechnet
    for (var x in freq) {
      var temp = (factor1 * pow(x, 3)) /
          ((pow(x, 2) + factor2) *
              (pow(x, 2) + factor1) *
              sqrt(pow(x, 2) + factor3));
      this.result.add(20 * log(temp) * log10e - 20 * log(offset) * log10e);
    }
  }

  Weighting.c(int samplingFrequency, int length) {
    //Fs*(0:(L/2))/L;
    this.result = List();
    List<double> freq = List(length ~/ 2);
    //List<double> freq = List(length);
    double factor = samplingFrequency / length;
    var offset = (factor1 * pow(1000, 2)) /
        ((pow(1000, 2) + factor2) * (pow(1000, 2) + factor1));

    for (int i = 0; i < length / 2; i++) {
      freq[i] = i * factor;
    }

    // hier wird A(f) berechnet
    for (var x in freq) {
      var temp = (factor1 * pow(x, 2)) /
          ((pow(x, 2) + factor2) * (pow(x, 2) + factor1));
      this.result.add(20 * log(temp) * log10e - 20 * log(offset) * log10e);
    }
  }

  Weighting.d(int samplingFrequency, int length) {
    List<double> freq = List(length ~/ 2);
    //List<double> freq = List(length);

    double factor = samplingFrequency / length;
    this.result = List();

    for (int i = 0; i < length / 2; i++) {
      freq[i] = i * factor;
    }

    for (var x in freq) {
      double temp1 =
          (pow((1037918.48 - pow(x, 2)), 2) + 1080768.15 * pow(x, 2)) /
              (pow((9837328 - pow(x, 2)), 2) + 11723776 * pow(x, 2)); // h(f)
      double temp2 = (x / (6.8966888496476 * pow(10, -5))); //RD(f) ohne Wurzel
      temp2 *= sqrt(temp1 /
          ((pow(x, 2) + 79919.29) * (pow(x, 2) + 1345600))); // RD(f) fertig

      this.result.add(20 * log(temp2) * log10e);
    }
  }
}
