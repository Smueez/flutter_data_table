import 'package:flutter/material.dart';

/// this class is used to give width and heights to the UI
class FlutterDataTableResponsive {
  /// this is for the width
  static double width(double p, BuildContext context) {
    return MediaQuery.of(context).size.width * (p / 100);
  }
  /// this is for the height
  static double height(double p, BuildContext context) {
    return MediaQuery.of(context).size.height * (p / 100);
  }

  /// this is for the pixel
  static double pixel(double p, BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio * p ;
  }
}
