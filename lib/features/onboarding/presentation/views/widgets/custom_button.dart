import 'package:flutter/material.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/core/theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.backgroundColor = AppColors.primaryColor,
    this.onPressed,
    this.textColor = AppColors.black,
  });
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: AppTextStyles.font64DarkReg.copyWith(
          fontFamily: 'BebasNeue',
          fontSize: 20,
          color: textColor,
        ),
      ),
    );
  }
}
