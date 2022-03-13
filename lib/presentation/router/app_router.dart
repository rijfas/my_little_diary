import 'package:flutter/material.dart';
import 'package:my_little_diary/data/models/diary.dart';
import 'package:my_little_diary/presentation/screens/diary_screen/diary_screen.dart';
import 'package:my_little_diary/presentation/screens/home_screen/home_screen.dart';

class AppRouter {
  const AppRouter._();
  static const homeScreen = 'home-screen';
  static const diaryScreen = 'diary-screen';

  static Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case diaryScreen:
        if (routeSettings.arguments != null) {
          return MaterialPageRoute(
            builder: (_) => DiaryScreen(
              diary: routeSettings.arguments as Diary,
            ),
          );
        }
        return MaterialPageRoute(builder: (_) => const DiaryScreen());
    }

    throw Exception("Invalid Route");
  }
}
