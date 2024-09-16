import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/routes/app_router.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/core/theme/app_text_styles.dart';
import 'package:talent_hub/features/onboarding/presentation/views/widgets/custom_button.dart';
import 'package:talent_hub/features/onboarding/presentation/views/widgets/onboarding_view_background.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const OnboardingViewBackground(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'KEEP AN EYE ON',
                textAlign: TextAlign.left,
                style: AppTextStyles.font64DarkReg.copyWith(
                  fontFamily: 'BebasNeue',
                  fontSize: 40,
                ),
              ),
              Text(
                'YOUR TALENT',
                textAlign: TextAlign.left,
                style: AppTextStyles.font64DarkReg.copyWith(
                  fontFamily: 'BebasNeue',
                  fontSize: 40,
                ),
              ),
              vGap(40),
              CustomButton(
                text: 'LOGIN',
                onPressed: () {
                  context.pushNamed(AppRouter.login);
                },
                textColor: AppColors.white,
              ),
              vGap(8),
              CustomButton(
                text: 'CREATE ACCOUNT',
                onPressed: () {
                  context.pushNamed(AppRouter.register);
                },
                backgroundColor: const Color(0xFFEEEEEE),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
