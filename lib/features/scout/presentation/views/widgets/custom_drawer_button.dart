import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/core/theme/app_colors.dart';

class CustomDrawerButton extends StatelessWidget {
  const CustomDrawerButton(
      {super.key, required this.title, required this.icon, this.onTap});

  final String title;
  final void Function()? onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColor,
        ),
        child: Row(
          children: [
            Icon(
              //size: 30,
              icon,
              color: AppColors.white,
            ),
            hGap(10),
            Text(
              title,
              style: const TextStyle(
                //fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
