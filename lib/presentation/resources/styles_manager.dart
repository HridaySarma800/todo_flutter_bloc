import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle? _getTextStyle(
    double fontSize, String fontFamily, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight);
}

TextStyle? headline1({double fontSize = FontSize.f28, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.bold, color);
}

TextStyle? headline2({double fontSize = FontSize.f24, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.bold, color);
}

TextStyle? headline3({double fontSize = FontSize.f22, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.medium, color);
}

TextStyle? subHeading({double fontSize = FontSize.f18, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.regular, color);
}

TextStyle? body({double fontSize = FontSize.f16, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.regular, color);
}

TextStyle? caption({double fontSize = FontSize.f12, required Color color}) {
  return _getTextStyle(
      fontSize, FontConstants.fontFamily, FontWeightManager.light, color);
}
