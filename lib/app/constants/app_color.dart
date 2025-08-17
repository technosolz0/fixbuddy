import 'package:flutter/material.dart';

// class AppColors {
//   AppColors._(); // Private constructor to prevent instantiation

//   static const Color primaryColor = Color.fromARGB(255, 250, 201, 78);
//   static const Color secondaryColor = Color.fromARGB(255, 250, 204, 89);
//   static const Color tritoryColor = Color(0xFFFFD97C);
//   static const Color whiteColor = Color(0xFFFFFFFF);
//   static const Color grayColor = Color(0xFFD9D9D9);
//   static const Color lightgrayColor = Color.fromARGB(255, 234, 234, 234);
//   static const Color textColor = Color(0xFF333333);
//   static const Color blackColor = Color(0xFF030303);
//   static const Color successColor = Color(0xFF4CAF50);
//   static const Color errorColor = Color(0xFFF44336);
// }

import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary Theme Colors
  static const Color primaryColor = Color(0xFFFAC94E);
  static const Color secondaryColor = Color(0xFFFACC59);
  static const Color tritoryColor = Color(0xFFFFD97C);

  // Neutral Colors
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color grayColor = Color(0xFFD9D9D9);
  static const Color lightGrayColor = Color(0xFFEAEAEA);
  static const Color textColor = Color(0xFF333333);
  static const Color blackColor = Color(0xFF030303);

  // Status Colors
  static const Color successColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFF44336);
  static const Color warningColor = Color(0xFFFFC107);

  // Gradient Themes
  static const Gradient lightThemeGradient = LinearGradient(
    colors: [secondaryColor, tritoryColor, whiteColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const Gradient darkThemeGradient = LinearGradient(
    colors: [secondaryColor, tritoryColor, blackColor],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
