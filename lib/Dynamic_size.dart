import 'package:flutter/material.dart';

class DynamicSize  {


  static double height(double percentage, BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return height * percentage;
  }
  static double availableHeight(double percentage, BuildContext context) {
    var availableHeight  = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return availableHeight * percentage;
  }
  static double heightInPixelRatio(double percentage, BuildContext context) {
    double logicalPixelHeight = MediaQuery.of(context).size.height;
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    double devicePixelHeight = logicalPixelHeight * devicePixelRatio;
    return devicePixelHeight * percentage;
  }

  static double width(double percentage, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width * percentage;
  }
  static double widthInPixelRatio(double percentage, BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
    double devicePixelWidth = width * devicePixelRatio;
    return devicePixelWidth * percentage;
  }


}