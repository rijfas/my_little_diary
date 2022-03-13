import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../core/utils/writable_color.dart';

part 'diary.g.dart';

@HiveType(typeId: 1)
class Diary {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final DateTime createdAt;
  @HiveField(3)
  final Color color;
  @HiveField(4)
  final String content;

  Diary({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.color,
    required this.content,
  });

  Diary copyWith({
    String? id,
    String? title,
    DateTime? createdAt,
    Color? color,
    String? content,
  }) {
    return Diary(
      id: id ?? this.id,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      color: color ?? this.color,
      content: content ?? this.content,
    );
  }
}
