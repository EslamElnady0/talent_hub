import 'package:flutter/material.dart';

import '../../features/home/presentation/home_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';

class AppRouter {
  static const String onboarding = '/onboarding';
  static const String home = '/home';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (context) => const SplashView());
      case home:
        return MaterialPageRoute(builder: (context) => const HomeView());
      default:
        return null;
    }
  }
}
