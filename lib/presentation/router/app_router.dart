import 'package:flutter/material.dart';
import 'package:my_little_diary/presentation/screens/diary_screen/diary_screen.dart';

import '../screens/home_screen/home_screen.dart';

class AppRouter {
  const AppRouter._();
  static const homeScreen = 'home-screen';
  static const diaryScreen = 'diary-screen';
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case diaryScreen:
        return MaterialPageRoute(builder: (_) => const DiaryScreen());
      default:
        throw Exception('Invalid Route Reached');
    }
  }
}
