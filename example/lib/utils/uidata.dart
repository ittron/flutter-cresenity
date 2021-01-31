

import 'dart:ui';

import 'package:flutter/material.dart';

class UIData {


  static const Color primaryColor = Color(0xffcc1923);

  static const String hexPrimaryColor = '#cc1923';
  static const Color primaryTextColor = Colors.white;
  static List<Color> primaryGradients = [
    Color(0xffe51c23),Color(0xffa2121d  )

  ];


  static themeData() {
    return ThemeData(
        primaryColor: UIData.primaryColor,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
