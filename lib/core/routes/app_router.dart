import 'package:flutter/material.dart';
import 'package:talent_hub/core/models/user_model.dart';

import 'package:talent_hub/features/chat/presentation/views/chat_details_view.dart';
import 'package:talent_hub/features/chat/presentation/views/chat_inbox_view.dart';

import 'package:talent_hub/features/auth/presentation/views/forgot_pass_view/forgot_pass_view.dart';
import 'package:talent_hub/features/auth/presentation/views/login_view/login_view.dart';
import 'package:talent_hub/features/auth/presentation/views/register_view/register_view.dart';

import 'package:talent_hub/features/player/presentation/views/widgets/post/create_post_view.dart';
import 'package:talent_hub/features/scout/presentation/views/scout_view.dart';

import 'package:talent_hub/features/splash/presentation/views/splash_view.dart';

import '../../features/home/presentation/home_view.dart';
import '../../features/onboarding/presentation/views/onboarding_view.dart';
import '../../features/player/presentation/views/player_profile_view.dart';

class AppRouter {
  static const String onboarding = '/onboarding';
  static const String splash = '/';
  static const String home = '/home';

  static const String chatInbox = '/chatInbox';
  static const String chatDetails = '/chatDetails';

  static const String scout = '/scout';
  static const String player = '/player';
  static const String playerProfile = '/playerProfile';
  static const String post = '/post';

  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onboarding:
        return MaterialPageRoute(builder: (context) => const OnBoardingView());
      case home:
        return MaterialPageRoute(builder: (context) => const HomeView());

      case scout:
        return MaterialPageRoute(builder: (context) => const ScoutView());

      // case player:
      //   return MaterialPageRoute(builder: (context) => const PlayerView());

      case playerProfile:
        return MaterialPageRoute(
            builder: (context) => const PlayerProfileView());

      case post:
        var args = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (context) => const CreatePostView(),
            settings: RouteSettings(arguments: args));

      case splash:
        return MaterialPageRoute(builder: (context) => const SplashView());

      case chatDetails:
        var args = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (context) => const ChatDetailsView(),
            settings: RouteSettings(arguments: args));

      case chatInbox:
        return MaterialPageRoute(builder: (context) => const ChatInboxView());

      case login:
        return MaterialPageRoute(builder: (context) => const LoginView());

      case register:
        return MaterialPageRoute(builder: (context) => const RegisterView());

      case forgotPassword:
        return MaterialPageRoute(builder: (context) => const ForgotPassView());

      default:
        return null;
    }
  }
}
