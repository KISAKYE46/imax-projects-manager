import 'package:flutter/material.dart';

class ThemeColors {
  // static var colorPrimary = Colors.red;
  // static var systemNavigationColor = Colors.white;
  // static var systemColorLight = Colors.white;
  // static var systemColorOnLight = Colors.black87;
  // static const systemPrimarySwatch = Colors.red;
  // static const systemSubtitleColor = Colors.black45;

  // static var colorPrimary = Color.fromARGB(255, 124, 211, 127);
  // static var systemNavigationColor = Colors.white;
  // static var systemColorLight = Colors.white;
  // static var systemColorOnLight = Colors.black87;
  // static const systemPrimarySwatch = Colors.green;
  // static const systemSubtitleColor = Colors.black45;

  static var colorPrimary = Color.fromARGB(248, 18, 165, 153);
  static var systemNavigationColor = Colors.white;
  static var systemColorLight = Colors.white;
  static var systemColorOnLight = Colors.black87;
  static const systemPrimarySwatch = Colors.blue;
  static const systemSubtitleColor = Colors.black45;
  static const transparent = Color.fromARGB(0, 252, 251, 251);
  static const lightBg = Color.fromARGB(255, 252, 250, 250);

  static var buttonColor = StateBasedColor(1);
}

class StateBasedColor extends MaterialStateColor {
  StateBasedColor(int defaultValue) : super(defaultValue);
  @override
  Color resolve(Set<MaterialState> states) {
    return ThemeColors.colorPrimary;
  }
}

class StateBtnColor extends MaterialStateColor {
  StateBtnColor(int defaultValue) : super(defaultValue);
  @override
  Color resolve(Set<MaterialState> states) {
    if (states.isNotEmpty) {
      if (states.first == MaterialState.pressed) {
        return ThemeColors.systemColorLight;
      }
    }
    return ThemeColors.colorPrimary;
  }
}
