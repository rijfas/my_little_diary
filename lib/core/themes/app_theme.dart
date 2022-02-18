import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  const AppTheme._();
  static const lightPrimaryColor = Color.fromARGB(255, 73, 71, 83);
  static const lightSecondaryColor = Color(0xFFEEEEF2);
  static const lightDisabledColor = Color(0xFFC8C9DE);
  static final lightTheme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: lightSecondaryColor,
    iconTheme: const IconThemeData(
      color: AppTheme.lightDisabledColor,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: lightSecondaryColor,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: lightPrimaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
    ),
    textTheme: GoogleFonts.nunitoTextTheme(),
  );
}
