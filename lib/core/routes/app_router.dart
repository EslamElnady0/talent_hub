import 'package:flutter/material.dart';
import 'package:talent_hub/features/auth/presentation/views/login_view/login_view.dart';
import 'package:talent_hub/features/auth/presentation/views/register_view/register_view.dart';
import 'package:talent_hub/features/scout/presentation/views/scout_view.dart';

import 'package:talent_hub/features/splash/presentation/views/splash_view.dart';

import '../../features/home/presentation/home_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';

class AppRouter {
  static const String onboarding = '/onboarding';
  static const String splash = '/';
  static const String home = '/home';
  static const String scout = '/scout';
  static const String login = '/login';
  static const String register = '/register';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (context) => const OnBoardingView());
      case home:
        return MaterialPageRoute(builder: (context) => const HomeView());

      case scout:
        return MaterialPageRoute(builder: (context) => const ScoutView());

      case splash:
        return MaterialPageRoute(builder: (context) => const SplashView());

      case login:
        return MaterialPageRoute(builder: (context) => const LoginView());

      case register:
        return MaterialPageRoute(builder: (context) => const RegisterView());

      default:
        return null;
    }
  }
}
