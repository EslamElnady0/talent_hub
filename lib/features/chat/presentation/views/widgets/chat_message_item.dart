import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/theme/app_colors.dart';

import '../../../../../core/theme/app_text_styles.dart';

class ChatMessageItem extends StatelessWidget {
  final String message;
  final bool isSender;
  const ChatMessageItem(
      {super.key, required this.message, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender
          ? AlignmentDirectional.centerStart
          : AlignmentDirectional.centerEnd,
      child: IntrinsicWidth(
        child: Container(
          constraints: BoxConstraints(maxWidth: 250.w),
          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
          decoration: BoxDecoration(
              color: isSender ? AppColors.primaryColor : Colors.grey.shade900,
              borderRadius: isSender
                  ? BorderRadius.only(
                      topRight: Radius.circular(10.r),
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r))
                  : BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      bottomLeft: Radius.circular(10.r),
                      bottomRight: Radius.circular(10.r))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(message, style: AppTextStyles.font15WhiteW500),
              Text("12:00", style: AppTextStyles.font12WhiteW500),
            ],
          ),
        ),
      ),
    );
  }
}
