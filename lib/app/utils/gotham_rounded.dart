import 'package:fixbuddy/app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/utils/extensions.dart';

class GothamRounded {
  static BuildContext context = Get.context!;

  static TextStyle _textStyle({
    required FontWeight weight,
    double? fontSize,
    Color? color,
    TextDecoration? decoration,
    double letterSpacing = 0.6,
  }) {
    return TextStyle(
      fontFamily: ThemeClass.gothamRounded,
      fontWeight: weight,
      color: color ??
          (context.isLightTheme
              ? ThemeClass.lightModeTextColor
              : ThemeClass.darkModeTextColor),
      fontSize: fontSize,
      decoration: decoration,
      letterSpacing: letterSpacing,
    );
  }

  static TextStyle thin({double? fontSize, Color? color, TextDecoration? decoration}) =>
      _textStyle(weight: FontWeight.w100, fontSize: fontSize, color: color, decoration: decoration);

  static TextStyle extraLight({double? fontSize, Color? color, TextDecoration? decoration}) =>
      _textStyle(weight: FontWeight.w200, fontSize: fontSize, color: color, decoration: decoration);

  static TextStyle book({double? fontSize, Color? color, TextDecoration? decoration}) =>
      _textStyle(weight: FontWeight.w300, fontSize: fontSize, color: color, decoration: decoration);

  static TextStyle regular({double? fontSize, Color? color, TextDecoration? decoration}) =>
      _textStyle(weight: FontWeight.w400, fontSize: fontSize, color: color, decoration: decoration);

  static TextStyle medium({double? fontSize, Color? color, TextDecoration? decoration}) =>
      _textStyle(weight: FontWeight.w500, fontSize: fontSize, color: color, decoration: decoration);

  static TextStyle semiBold({double? fontSize, Color? color, TextDecoration? decoration}) =>
      _textStyle(weight: FontWeight.w600, fontSize: fontSize, color: color, decoration: decoration);

  static TextStyle bold({double? fontSize, Color? color, TextDecoration? decoration}) =>
      _textStyle(weight: FontWeight.w700, fontSize: fontSize, color: color, decoration: decoration);

  static TextStyle extraBold({double? fontSize, Color? color, TextDecoration? decoration}) =>
      _textStyle(weight: FontWeight.w800, fontSize: fontSize, color: color, decoration: decoration);

  static TextStyle blackThick({double? fontSize, Color? color, TextDecoration? decoration}) =>
      _textStyle(weight: FontWeight.w900, fontSize: fontSize, color: color, decoration: decoration);
}
                      