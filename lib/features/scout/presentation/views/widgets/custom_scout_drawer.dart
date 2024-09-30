import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/app_assets.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/custom_drawer_section.dart';

class CustomScoutDrawer extends StatelessWidget {
  const CustomScoutDrawer({super.key, required this.userModel});
  final UserModel userModel;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundImage: NetworkImage(userModel.imageUrl!),
                ),
                Text(
                  "${userModel.name}\n${userModel.email}",
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
