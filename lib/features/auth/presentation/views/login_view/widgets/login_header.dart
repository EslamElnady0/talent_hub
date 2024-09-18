import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/app_assets.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/core/theme/app_text_styles.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      width: double.infinity,
      height: context.height * 0.3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: [
                  Image.asset(
                    AppAssets.appLogo,
                    color: AppColors.white,
                  ),
                  hGap(7),
                  Text(
                    'TalentHub',
                    style: AppTextStyles.font20DarkW600.copyWith(
                      fontFamily: 'AzeretMono',
                      fontSize: 21,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          hGap(60),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'SIGN IN WITH YOUR \nACCOUNT',
                  textAlign: TextAlign.start,
                  style: AppTextStyles.font64DarkReg.copyWith(
                    fontFamily: 'BebasNeue',
                    fontSize: 20,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Image.asset(
                    'assets/images/sign_in.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
