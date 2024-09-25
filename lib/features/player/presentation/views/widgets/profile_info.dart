import 'package:flutter/material.dart';

import '../../../../../core/helpers/app_assets.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_colors.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              radius: 80,
              child: CircleAvatar(
                radius: 78,
                backgroundImage: AssetImage(AppAssets.player),
              ),
            ),
            CircleAvatar(
              radius: 19,
              backgroundColor: AppColors.white,
              child: IconButton(
                icon: const Icon(
                  Icons.edit,
                  color: AppColors.primaryColor,
                  size: 19,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        vGap(15),
        const Text(
          "Abdelrahman",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const Text("abdelrahman@gmail.com", style: TextStyle(fontSize: 20)),
      ],
    );
  }
}
