import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/app_assets.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/theme/app_text_styles.dart';

class OnboardingViewBackground extends StatelessWidget {
  const OnboardingViewBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
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
          ),
        ),
        Image.asset(
          AppAssets.onBoardingVector2,
          fit: BoxFit.fill,
        ),
        Image.asset(
          AppAssets.onBoardingLogo,
          fit: BoxFit.fill,
        ),
        Image.asset(
          AppAssets.onBoardingVector1,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
