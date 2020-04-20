class meas{
  String recFilename = 'default';
  int recThresholdvalue = 20;
  int recordTime = 0;
  int recAvgVal = 20;
  int recMaxVal = 20;
  int recMinVal = 20;
  int recActVal = 20;

// Konstruktor
  meas(String recFilename, int recThresholdvalue){
    this.recFilename = recFilename;
    this.recThresholdvalue = recThresholdvalue;
  }

}