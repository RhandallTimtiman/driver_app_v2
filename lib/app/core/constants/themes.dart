import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  static final lightTheme = ThemeData(
    primaryColor: const Color.fromRGBO(0, 167, 229, 1),
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primaryColor: const Color.fromRGBO(0, 167, 229, 1),
    scaffoldBackgroundColor: Colors.black,
    brightness: Brightness.dark,
  );
}
