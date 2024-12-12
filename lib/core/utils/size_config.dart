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
    if (screenWidth > screenHeight) {
      blockSizeHorizontal = screenHeight / baseWidth;
    }
    return inputWidth * blockSizeHorizontal;
  }

  static double height(double inputHeight) {
    if (screenWidth > screenHeight) {
      blockSizeVertical = screenWidth / baseHeight;
    }
    return inputHeight * blockSizeVertical;
  }

  static double textSize(double inputSize) {
    if (screenWidth > screenHeight) {
      blockSizeHorizontal = screenHeight / baseWidth;
    }
    return inputSize * blockSizeHorizontal;
  }
}
