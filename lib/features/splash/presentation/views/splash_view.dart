import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/app_assets.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/theme/app_text_styles.dart';
import 'package:talent_hub/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:talent_hub/features/scout/presentation/views/scout_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedSplashScreen(
          splash: Column(
            children: [
              Image.asset(AppAssets.appLogo),
              hGap(7),
              Text(
                'TalentHub',
                style: AppTextStyles.font20DarkW600.copyWith(
                  fontFamily: 'AzeretMono',
                  fontSize: 21,
                ),
              ),
            ],
          ),
          nextScreen: FirebaseAuth.instance.currentUser?.uid == null
              ? const OnBoardingView()
              : const ScoutView(),
          duration: 2500,
          splashTransition: SplashTransition.scaleTransition,
        ),
      ),
    );
  }
}
