import 'package:flutter/material.dart';

import '../../features/home/presentation/home_view.dart';
import '../../features/splash/presentation/views/splash_view.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String home = '/home';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case home:
        return MaterialPageRoute(builder: (context) => const HomeView());
      default:
        return null;
    }
  }
}
