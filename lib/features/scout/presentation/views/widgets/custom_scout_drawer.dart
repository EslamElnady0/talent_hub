import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/helpers/app_assets.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/helpers/show_toast.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/core/routes/app_router.dart';
import 'package:talent_hub/features/scout/presentation/views/widgets/custom_drawer_button.dart';

import '../../../../../core/widgets/user_image_circle_avatar.dart';

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
                InkWell(
                    onTap: () {
                      context.pushNamed(AppRouter.profileView,
                          arguments: userModel);
                    },
                    child: UserImageCircleAvatar(
                      image: userModel.imageUrl,
                      radius: 40.r,
                    )),
                Text(
                  "${userModel.name}\n${userModel.email}",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          CustomDrawerButton(
            title: "Profile",
            icon: Icons.person,
            onTap: () {
              context.pushNamed(AppRouter.profileView, arguments: userModel);
            },
          ),
          CustomDrawerButton(
            title: "Logout",
            icon: Icons.logout,
            onTap: () {
              FirebaseAuth.instance.signOut();
              context.pushReplacementNamed(AppRouter.login);
              showToast(toastMsg: 'Logout..', state: ToastStates.warining);
            },
          ),
          const Spacer(),
          Image.asset(AppAssets.drawer),
          const Spacer(),
        ],
      ),
    );
  }
}
