import 'package:flutter/material.dart';
import 'package:my_little_diary/presentation/screens/entry_create_screen/entry_create_screen.dart';
import 'package:my_little_diary/presentation/screens/entry_list_screen/entry_list_screen.dart';
import 'package:my_little_diary/presentation/screens/entry_view_screen/entry_view_screen.dart';

import '../screens/home_screen/home_screen.dart';

class AppRouter {
  const AppRouter._();
  static const homeScreen = 'home-screen';
  static const entryListScreen = 'entry-list-screen';
  static const entryCreateScreen = 'entry-create-screen';
  static const entryViewScreen = 'entry-view-screen';
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case entryListScreen:
        return MaterialPageRoute(builder: (_) => const EntryListScreen());
      case entryCreateScreen:
        return MaterialPageRoute(builder: (_) => const EntryCreateScreen());
      case entryViewScreen:
        return MaterialPageRoute(builder: (_) => const EntryViewScreen());
      default:
        throw Exception('Invalid Route Reached');
    }
  }
}
