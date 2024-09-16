import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/app_assets.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/custom_drawer_section.dart';

class CustomScoutDrawer extends StatelessWidget {
  const CustomScoutDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.white,
                      radius: 44,
                      child: CircleAvatar(
                        radius: 41,
                        backgroundImage: AssetImage(AppAssets.player),
                      ),
                    ),
                    CircleAvatar(
                      radius: 19,
                      backgroundColor: AppColors.white,
                      child: IconButton(
                        icon: const Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.primaryColor,
                          size: 19,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Eslam Elsayed\neslimelseyd@gmail.com",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const CustomDrawerSection(
            title: "Profile",
            icon: Icons.person,
          ),
          const CustomDrawerSection(
            title: "Settings",
            icon: Icons.settings,
          ),
          const Spacer(),
          Image.asset(AppAssets.drawer),
          const Spacer(),
        ],
      ),
    );
  }
}
