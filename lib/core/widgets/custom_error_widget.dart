import 'package:flutter/material.dart';
import 'package:talent_hub/core/theme/app_colors.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errorMassage});
  final String errorMassage;
  final Color? color = AppColors.primaryColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Text(
            errorMassage,
            style: TextStyle(
              fontSize: 18,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
