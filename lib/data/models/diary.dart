import 'package:flutter/material.dart';

class Diary {
  final String id;
  final DateTime createdAt;
  final String title;
  final MaterialColor color;
  const Diary({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.color,
  });
}
