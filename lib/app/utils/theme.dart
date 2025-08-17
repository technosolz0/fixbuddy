// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:fixbuddy/app/utils/extensions.dart';
// import 'package:fixbuddy/main.dart';

// class ThemeClass {
//   /// primary bluish color
//   static const primaryColor = Color(0xff31496F);
//   static const primaryColorLight = Color(0xff3553B4);
//   static const cardColor = Color(0xff3B525A);
//   static const cardLightColor = Color(0xff455895);

//   /// secondary light brown color
//   static const secondaryColor = Color(0xff7EB1FE);
//   static const secondaryLightColor = Color(0xffB5C1C6);

//   /// action colors
//   static const errorRed = Color(0xffea0000);
//   static const dimErrorRed = Color(0xffcc3c3c);
//   static const successGreen = Color(0xff80B650);
//   static const infoYello = Color(0xffF7A12F);
//   static const likeColor = Color(0xffEF3A43);

//   //other colors
//   static const whiteColor = Colors.white;
//   static const backgrounColor = Color(0xff060809);
//   static const backgrounColorLight = Color(0xffFBFBFF);

//   static const lightModeTextColor = Color(0xff29393F);
//   static const darkModeTextColor = Colors.white;
//   static Color textColor = appThemeMode.isLightTheme
//       ? lightModeTextColor
//       : darkModeTextColor;

//   static BoxShadow lightBoxShadow = BoxShadow(
//     offset: const Offset(0, 0),
//     blurRadius: 16,
//     color: const Color(0xff3553B4).withOpacity(0.1),
//   );
//   //font families
//   static const String gothamRounded = 'Gotham';

//   static ThemeData theme = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.dark,
//     fontFamily: gothamRounded,
//     iconTheme: const IconThemeData(color: primaryColor),
//     scaffoldBackgroundColor: backgrounColor,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: backgrounColor,
//       surfaceTintColor: backgrounColor,
//       elevation: 0,
//     ),
//     bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 0),
//     colorScheme: const ColorScheme.dark(
//       brightness: Brightness.dark,
//       primary: primaryColor,
//       secondary: secondaryColor,
//       onSurface: secondaryLightColor,
//       onPrimary: backgrounColor,
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       labelStyle: const TextStyle(color: secondaryLightColor),
//       iconColor: secondaryLightColor,
//       suffixIconColor: secondaryLightColor,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: const BorderSide(color: secondaryLightColor, width: 1),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: const BorderSide(color: secondaryLightColor, width: 1),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: const BorderSide(color: secondaryLightColor, width: 1),
//       ),
//     ),
//   );

//   static ThemeData lightTheme = ThemeData(
//     useMaterial3: true,
//     brightness: Brightness.light,
//     fontFamily: gothamRounded,
//     iconTheme: const IconThemeData(color: primaryColorLight),
//     scaffoldBackgroundColor: backgrounColorLight,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: backgrounColorLight,
//       surfaceTintColor: backgrounColorLight,
//       elevation: 0,
//     ),
//     bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 0),
//     colorScheme: const ColorScheme.light(
//       brightness: Brightness.light,
//       primary: primaryColorLight,
//       secondary: secondaryColor,
//       onSurface: secondaryLightColor,
//       onPrimary: backgrounColorLight,
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       labelStyle: const TextStyle(color: secondaryLightColor),
//       iconColor: secondaryLightColor,
//       suffixIconColor: secondaryLightColor,
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: BorderSide.none,
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: BorderSide.none,
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12.r),
//         borderSide: BorderSide.none,
//       ),
//     ),
//   );
// }

// class GothamRounded {
//   static BuildContext context = Get.context!;

//   /// FontWeight.w100
//   static TextStyle thin({
//     double? fontSize,
//     Color? color,
//     TextDecoration? decoration,
//   }) {
//     return TextStyle(
//       fontFamily: ThemeClass.gothamRounded,
//       fontWeight: FontWeight.w100,
//       color:
//           color ??
//           (context.isLightTheme
//               ? ThemeClass.lightModeTextColor
//               : ThemeClass.darkModeTextColor),
//       fontSize: fontSize,
//       decoration: decoration,
//     );
//   }

//   /// FontWeight.w200
//   static TextStyle extraLight({
//     double? fontSize,
//     Color? color,
//     TextDecoration? decoration,
//   }) {
//     return TextStyle(
//       fontFamily: ThemeClass.gothamRounded,
//       fontWeight: FontWeight.w200,
//       color:
//           color ??
//           (context.isLightTheme
//               ? ThemeClass.lightModeTextColor
//               : ThemeClass.darkModeTextColor),
//       fontSize: fontSize,
//       decoration: decoration,
//       letterSpacing: 0.6,
//     );
//   }

//   /// FontWeight.w300
//   static TextStyle book({
//     double? fontSize,
//     Color? color,
//     TextDecoration? decoration,
//   }) {
//     return TextStyle(
//       fontFamily: ThemeClass.gothamRounded,
//       fontWeight: FontWeight.w300,
//       color:
//           color ??
//           (context.isLightTheme
//               ? ThemeClass.lightModeTextColor
//               : ThemeClass.darkModeTextColor),
//       fontSize: fontSize,
//       decoration: decoration,
//       letterSpacing: 0.6,
//     );
//   }

//   /// FontWeight.w400
//   static TextStyle regular({
//     double? fontSize,
//     Color? color,
//     TextDecoration? decoration,
//   }) {
//     return TextStyle(
//       fontFamily: ThemeClass.gothamRounded,
//       fontWeight: FontWeight.w400,
//       color:
//           color ??
//           (context.isLightTheme
//               ? ThemeClass.lightModeTextColor
//               : ThemeClass.darkModeTextColor),
//       fontSize: fontSize,
//       decoration: decoration,
//       letterSpacing: 0.6,
//     );
//   }

//   /// FontWeight.w500
//   static TextStyle medium({
//     double? fontSize,
//     Color? color,
//     TextDecoration? decoration,
//   }) {
//     return TextStyle(
//       fontFamily: ThemeClass.gothamRounded,
//       fontWeight: FontWeight.w500,
//       color:
//           color ??
//           (context.isLightTheme
//               ? ThemeClass.lightModeTextColor
//               : ThemeClass.darkModeTextColor),
//       fontSize: fontSize,
//       decoration: decoration,
//       letterSpacing: 0.6,
//     );
//   }

//   /// FontWeight.w600
//   static TextStyle semiBold({
//     double? fontSize,
//     Color? color,
//     TextDecoration? decoration,
//   }) {
//     return TextStyle(
//       fontFamily: ThemeClass.gothamRounded,
//       fontWeight: FontWeight.w600,
//       color:
//           color ??
//           (context.isLightTheme
//               ? ThemeClass.lightModeTextColor
//               : ThemeClass.darkModeTextColor),
//       fontSize: fontSize,
//       decoration: decoration,
//       letterSpacing: 0.6,
//     );
//   }

//   /// FontWeight.w700
//   static TextStyle bold({
//     double? fontSize,
//     Color? color,
//     TextDecoration? decoration,
//   }) {
//     return TextStyle(
//       fontFamily: ThemeClass.gothamRounded,
//       fontWeight: FontWeight.w700,
//       color:
//           color ??
//           (context.isLightTheme
//               ? ThemeClass.lightModeTextColor
//               : ThemeClass.darkModeTextColor),
//       fontSize: fontSize,
//       decoration: decoration,
//       letterSpacing: 0.6,
//     );
//   }

//   /// FontWeight.w800
//   static TextStyle extraBold({
//     double? fontSize,
//     Color? color,
//     TextDecoration? decoration,
//   }) {
//     return TextStyle(
//       fontFamily: ThemeClass.gothamRounded,
//       fontWeight: FontWeight.w800,
//       color:
//           color ??
//           (context.isLightTheme
//               ? ThemeClass.lightModeTextColor
//               : ThemeClass.darkModeTextColor),
//       fontSize: fontSize,
//       decoration: decoration,
//       letterSpacing: 0.6,
//     );
//   }

//   /// FontWeight.w900
//   static TextStyle blackThick({
//     double? fontSize,
//     Color? color,
//     TextDecoration? decoration,
//   }) {
//     return TextStyle(
//       fontFamily: ThemeClass.gothamRounded,
//       fontWeight: FontWeight.w900,
//       color:
//           color ??
//           (context.isLightTheme
//               ? ThemeClass.lightModeTextColor
//               : ThemeClass.darkModeTextColor),
//       fontSize: fontSize,
//       decoration: decoration,
//       letterSpacing: 0.6,
//     );
//   }
// }

import 'package:fixbuddy/app/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fixbuddy/main.dart';
import 'package:fixbuddy/app/utils/extensions.dart';

class ThemeClass {
  // Primary and secondary colors
  static const primaryColor = AppColors.primaryColor;
  static const primaryColorLight = AppColors.secondaryColor;

  // Card colors
  static const cardColor = AppColors.grayColor;
  static const cardLightColor = AppColors.lightGrayColor;

  // Action colors
  static const errorRed = AppColors.errorColor;
  static const successGreen = AppColors.successColor;

  // Other colors
  static const whiteColor = AppColors.whiteColor;
  static const backgrounColor = AppColors.blackColor;
  static const backgrounColorLight = AppColors.whiteColor;

  static const lightModeTextColor = AppColors.textColor;
  static const darkModeTextColor = AppColors.whiteColor;

  static Color textColor = appThemeMode.isLightTheme
      ? lightModeTextColor
      : darkModeTextColor;

  static BoxShadow lightBoxShadow = BoxShadow(
    offset: const Offset(0, 0),
    blurRadius: 16,
    color: primaryColor.withOpacity(0.1),
  );

  static const String gothamRounded = 'Gotham';

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: gothamRounded,
    iconTheme: const IconThemeData(color: primaryColor),
    scaffoldBackgroundColor: backgrounColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: backgrounColor,
      surfaceTintColor: backgrounColor,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 0),
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      primary: primaryColor,
      secondary: primaryColorLight,
      onSurface: AppColors.grayColor,
      onPrimary: backgrounColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: AppColors.grayColor),
      iconColor: AppColors.grayColor,
      suffixIconColor: AppColors.grayColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.grayColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.grayColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: const BorderSide(color: AppColors.grayColor, width: 1),
      ),
    ),
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: gothamRounded,
    iconTheme: const IconThemeData(color: primaryColor),
    scaffoldBackgroundColor: backgrounColorLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: backgrounColorLight,
      surfaceTintColor: backgrounColorLight,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(elevation: 0),
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: primaryColor,
      secondary: primaryColorLight,
      onSurface: AppColors.grayColor,
      onPrimary: backgrounColorLight,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(color: AppColors.grayColor),
      iconColor: AppColors.grayColor,
      suffixIconColor: AppColors.grayColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide.none,
      ),
    ),
  );
}
