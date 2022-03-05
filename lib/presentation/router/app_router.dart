import 'package:flutter/material.dart';
import 'package:my_little_diary/data/models/diary.dart';
import 'package:my_little_diary/data/models/models.dart';
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
  static const entryEditScreen = 'entry-edit-screen';
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case entryListScreen:
        return MaterialPageRoute(
          builder: (_) => EntryListScreen(
            diary: settings.arguments as Diary,
          ),
        );
      case entryCreateScreen:
        return MaterialPageRoute(
            builder: (_) => EntryCreateScreen(
                  diary: settings.arguments as Diary,
                ));
      case entryViewScreen:
        return MaterialPageRoute(builder: (_) {
          if (settings.arguments == null) throw Exception('Invalid Arguments');
          final arguments = settings.arguments as Map<String, dynamic>;
          return EntryViewScreen(
            diary: arguments['diary'] as Diary,
            entry: arguments['entry'] as Entry,
          );
        });
      case entryEditScreen:
        return MaterialPageRoute(builder: (_) {
          if (settings.arguments == null) throw Exception('Invalid Arguments');
          final arguments = settings.arguments as Map<String, dynamic>;
          return EntryCreateScreen(
            diary: arguments['diary'] as Diary,
            entry: arguments['entry'] as Entry,
          );
        });
      default:
        throw Exception('Invalid Route Reached');
    }
  }
}
