import 'package:flutter/material.dart';
import 'package:talent_hub/core/theme/app_colors.dart';

class CustomCircularLoadingIndicator extends StatelessWidget {
  const CustomCircularLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
