import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/theme/app_colors.dart';

class CustomChatTextField extends StatelessWidget {
  const CustomChatTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: 1,
      maxLines: 5,
      cursorColor: AppColors.primaryColor,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade900,
        hintText: 'Type a message...',
        hintStyle: TextStyle(color: Colors.grey.shade500),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: Colors.grey.shade700, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.send, color: AppColors.primaryColor),
          onPressed: () {},
        ),
      ),
    );
  }
}
