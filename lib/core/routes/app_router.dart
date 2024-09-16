import 'package:flutter/material.dart';
import 'package:talent_hub/features/scout/presentation/views/scout_view.dart';

import '../../features/home/presentation/home_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String scout = '/scout';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case home:
        return MaterialPageRoute(builder: (context) => const HomeView());
      case scout:
        return MaterialPageRoute(builder: (context) => const ScoutView());
      default:
        return null;
    }
  }
}
