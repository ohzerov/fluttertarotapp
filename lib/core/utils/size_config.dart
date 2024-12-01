import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static double baseWidth = 375;
  static double baseHeight = 812;

  static void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    blockSizeHorizontal = screenWidth / baseWidth;
    blockSizeVertical = screenHeight / baseHeight;
  }

  static double width(double inputWidth) {
    return inputWidth * blockSizeHorizontal;
  }

  static double height(double inputHeight) {
    return inputHeight * blockSizeVertical;
  }

  static double textSize(double inputSize) {
    return inputSize * blockSizeHorizontal;
  }
}
