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
    this.widget,
  });
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final void Function()? onPressed;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: widget ??
              Text(
                text,
                style: AppTextStyles.font64DarkReg.copyWith(
                  fontFamily: 'BebasNeue',
                  fontSize: 20,
                  color: textColor,
                ),
              ),
        ),
      ),
    );
  }
}
