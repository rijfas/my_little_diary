import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'data/models/models.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(DiaryAdapter());
  Hive.registerAdapter(EntryAdapter());
  Hive.registerAdapter(SettingsAdapter());
  runApp(const App());
}
