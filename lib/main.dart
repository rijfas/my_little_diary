import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:my_little_diary/data/models/diary.dart';
import 'package:my_little_diary/data/repositories/diary_repository.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(DiaryAdapter());
  await Hive.initFlutter();

  runApp(const App());
}
