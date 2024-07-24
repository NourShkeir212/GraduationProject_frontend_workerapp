

import 'package:flutter/material.dart';

class Dimensions {
  late double screenHeight;
  late double screenWidth;

  // ... rest of your fields ...
  Dimensions(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
  }

  // ... initialize rest of your fields ...
  //Dynamic Page view

  //font sizes

  double get font25 => 25 * screenWidth / 360;
  double get font24 => 24 * screenWidth / 360;
  double get font20 => 20 * screenWidth / 360;
  double get font18 => 18 * screenWidth / 360;
  double get font19 => 19 * screenWidth / 360;
  double get font16 => 16 * screenWidth / 360;
  double get font14 => 14 * screenWidth / 360;
  double get font13 => 13 * screenWidth / 360;
  double get font12 => 12 * screenWidth / 360;
  double get font10 => 10 * screenWidth / 360;

  //padding
  double get padding10 => 10 * screenHeight / 725.0;

  //width
  double get width55 => 55 * screenWidth /360.0;
  double get width5 => 5 * screenWidth /360.0;
  double get width10=> 10 * screenWidth /360.0;


  //heights
  double get height250 => 250 *screenHeight /725.0;
  double get height150 => 150 *screenHeight /725.0;
  double get height160 => 160 *screenHeight /725.0;
  double get height130 => 130 *screenHeight /725.0;
  double get height100 => 100 *screenHeight /725.0;
  double get height120 => 120 *screenHeight /725.0;
  double get height90 => 90 *screenHeight /725.0;
  double get height30 => 30 *screenHeight /725.0;
  double get height20 => 20 *screenHeight /725.0;
  double get height18 => 18 *screenHeight /725.0;
  double get height15 => 15 *screenHeight /725.0;
  double get height10 => 10 *screenHeight /725.0;
  double get height8 => 8 *screenHeight /725.0;
  double get height5 => 5 *screenHeight /725.0;
  double get height3 => 3 *screenHeight /725.0;
  double get height4 => 4 *screenHeight /725.0;

  //radius
  double get radius50 => 50 *screenHeight /725.0;
  double get radius30 => 30 *screenHeight /725.0;
  double get radius15 => 15 *screenHeight /725.0;
  double get radius10 => 10 *screenHeight /725.0;


  //auth screen dimensions
  double get topWidgetHeight => 300 * screenHeight/725.0;
  double get topWidgetPaddingTop => 90 * screenHeight/725.0;
  double get topWidgetPaddingLeft => 20 * screenWidth/360.0;

  double get buttonSignUpLocation => 525 * screenHeight/725.0;
  double get buttonSignInLocation => 405 * screenHeight/725.0;
  double get authSignUpStackHeight => 160 * screenHeight/725.0;
  double get authSignInStackHeight => 170 * screenHeight/725.0;
  double get authSignUpContainerStackHeight => 410 * screenHeight/725.0;
  double get authSignInContainerStackHeight => 280 * screenHeight/725.0;

}
