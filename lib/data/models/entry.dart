import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'entry.g.dart';

@HiveType(typeId: 2)
class Entry {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String diaryId;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final DateTime createdAt;
  @HiveField(4)
  final Color color;
  @HiveField(5)
  final String data;

  const Entry({
    required this.id,
    required this.diaryId,
    required this.title,
    required this.createdAt,
    required this.color,
    required this.data,
  });
}
