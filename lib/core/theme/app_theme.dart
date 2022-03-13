import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static const lightPrimaryColor = Color(0xFF000000);
  static const lightSecondaryColor = Color(0xFFEEEEF2);
  static const lightDisabledColor = Color(0xFFC8C9DE);
  static final lightTheme = ThemeData.light().copyWith(
    primaryColor: lightPrimaryColor,
    colorScheme: const ColorScheme.light().copyWith(primary: lightPrimaryColor),
    scaffoldBackgroundColor: lightSecondaryColor,
    iconTheme: const IconThemeData(
      color: AppTheme.lightDisabledColor,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: lightPrimaryColor,
      foregroundColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: lightSecondaryColor,
      foregroundColor: lightPrimaryColor,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: lightPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
    ),
  );
}
