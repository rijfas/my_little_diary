import 'dart:math';

import 'package:flutter/material.dart';

class RandomColor {
  RandomColor._();
  static Color randomColor() {
    const List<Color> _defaultColors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
      Colors.black,
    ];
    return _defaultColors[Random().nextInt(_defaultColors.length)];
  }
}
