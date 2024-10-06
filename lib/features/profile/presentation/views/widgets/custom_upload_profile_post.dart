import 'package:flutter/material.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/core/routes/app_router.dart';
import 'package:talent_hub/core/theme/app_colors.dart';

class CustomUploadProfilePost extends StatelessWidget {
  const CustomUploadProfilePost({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
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
                context.pushNamed(AppRouter.post, arguments: userModel);
              },
              label: const Text(
                'Share Your Talent',
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
