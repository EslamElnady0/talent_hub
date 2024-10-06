import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/app_assets.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/profile/presentation/manger/profile_cubit.dart';

class CustomStackImage extends StatelessWidget {
  const CustomStackImage({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = ProfileCubit.get(context);
    return SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                image: DecorationImage(
                    image: AssetImage(AppAssets.drawer), fit: BoxFit.cover),
              ),
            ),
          ),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.white,
                radius: 62,
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: profileCubit.profileImage != null
                      ? FileImage(profileCubit.profileImage!)
                      : CachedNetworkImageProvider(
                          userModel.imageUrl ?? "",
                        ),
                ),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[300]!.withOpacity(0.5),
                child: IconButton(
                  icon: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                  onPressed: () async {
                    profileCubit.getProfileImage();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
