import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/features/profile/presentation/views/widgets/custom_app_bar.dart';
import 'package:talent_hub/features/profile/presentation/views/widgets/custom_posts_profile.dart';
import 'package:talent_hub/features/profile/presentation/views/widgets/custom_upload_profile_post.dart';
import 'package:talent_hub/features/profile/presentation/views/widgets/profile_info.dart';

import '../../../../../core/DI/dependency_injection.dart';
import '../../../../../core/helpers/spacing.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const CustomAppBar(),
          ProfileInfo(userModel: userModel),
          if (userModel.role == 'player')
            userModel.id == getIt.get<FirebaseAuth>().currentUser!.uid
                ? CustomUploadProfilePost(userModel: userModel)
                : vGap(10),
          if (userModel.role == 'player')
            CustomPostsProfile(userModel: userModel)
        ],
      ),
    );
  }
}
