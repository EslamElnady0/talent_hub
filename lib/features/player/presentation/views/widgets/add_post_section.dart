import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/helpers/extensions.dart';
import 'package:talent_hub/core/models/user_model.dart';
import 'package:talent_hub/core/routes/app_router.dart';
import 'package:talent_hub/core/theme/app_colors.dart';

Widget addPostSection(BuildContext context, UserModel userModel) {
  return GestureDetector(
    onTap: () {
      context.pushNamed(AppRouter.post, arguments: userModel);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryColor,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.add,
            color: Colors.white,
            size: 30.r,
          ),
          Text(
            "Share Your Talent From Here",
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          ),
        ],
      ),
    ),
  );
}
