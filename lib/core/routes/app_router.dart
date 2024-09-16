import 'package:flutter/material.dart';

import 'package:talent_hub/features/chat/presentation/views/chat_details_view.dart';
import 'package:talent_hub/features/chat/presentation/views/chat_inbox_view.dart';

import 'package:talent_hub/features/scout/presentation/views/scout_view.dart';


import 'package:talent_hub/features/splash/presentation/views/splash_view.dart';


import '../../features/home/presentation/home_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';

class AppRouter {
  static const String onboarding = '/onboarding';
  static const String splash = '/';
  static const String home = '/home';

  static const String chatInbox = '/chatInbox';
  static const String chatDetails = '/chatDetails';

  static const String scout = '/scout';


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

      case chatDetails:
        return MaterialPageRoute(builder: (context) => const ChatDetailsView());
      case chatInbox:
        return MaterialPageRoute(builder: (context) => const ChatInboxView());
      default:
        return null;
    }
  }
}
