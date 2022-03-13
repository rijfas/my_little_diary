import 'package:flutter/material.dart';

class WritableColor {
  WritableColor._();
  static String asString({required Color color}) {
    return '${color.red}:${color.green}:${color.blue}';
  }

  static Color fromString(String string) {
    final List<int> rgb = string.split(':').map((e) => int.parse(e)).toList();
    return Color.fromARGB(255, rgb[0], rgb[1], rgb[2]);
  }
}
