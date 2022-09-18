import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:workers/values/colors.dart';
import 'package:workers/values/dimen.dart';

class SystemTheme {
  static var textStyle = TextStyle(color: ThemeColors.systemColorLight);
  static var newsCategoryTextStyle = TextStyle(fontWeight: FontWeight.bold);
  static var headingStyle = TextStyle(
      color: ThemeColors.systemColorLight,
      fontWeight: FontWeight.bold,
      fontSize: 16.0);
  static var fabMargin = EdgeInsets.all(systemPadding);
  static var fabTopMargin = EdgeInsets.only(top: systemPadding);
  static var fabBottomMargin = EdgeInsets.only(bottom: systemPadding);
  static var fabRLMargin =
      EdgeInsets.only(left: systemPadding, right: systemPadding);
  static var fabTBMargin =
      EdgeInsets.only(top: systemPadding, bottom: systemPadding);
  static var fabRLTMargin = EdgeInsets.only(
      top: systemPadding, right: systemPadding, left: systemPadding);
  static var fabRLBMargin = EdgeInsets.only(
      bottom: systemPadding, right: systemPadding, left: systemPadding);

  static var newsNewDateTextStyle = TextStyle(fontSize: 10);

  static var imageRadius = BorderRadius.circular(200);

  static var bottomSheetDecoration =
      BoxDecoration(borderRadius: BorderRadius.circular(12));
}
