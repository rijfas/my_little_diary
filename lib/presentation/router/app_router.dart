import 'package:flutter/material.dart';

import '../screens/home_screen/home_screen.dart';

class AppRouter {
  const AppRouter._();
  static const homeScreen = 'homeScreen';

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        throw Exception('Invalid Route Reached');
    }
  }
}
