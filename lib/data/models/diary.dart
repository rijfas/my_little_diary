import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:my_little_diary/core/utils/utils.dart';

part 'diary.g.dart';

@HiveType(typeId: 1)
class Diary {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final DateTime createdAt;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final MaterialColor color;

  Diary({
    required this.id,
    required this.createdAt,
    required this.title,
    required Color color,
  }) : color = Utils.createMaterialColor(color);
}
