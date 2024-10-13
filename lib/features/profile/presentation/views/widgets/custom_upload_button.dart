import 'package:flutter/material.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/profile/presentation/manger/profile_cubit.dart';

class CustomUploadButton extends StatelessWidget {
  const CustomUploadButton({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    ProfileCubit profileCubit = ProfileCubit.get(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white,
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              onPressed: () {
                profileCubit.uploadProfileImage(userModel: userModel);
              },
              label: const Text(
                'Update your profile image',
                style: TextStyle(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
