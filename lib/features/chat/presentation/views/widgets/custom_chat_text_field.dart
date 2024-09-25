import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20file%20cubit/send_file_cubit.dart';

class CustomChatTextField extends StatelessWidget {
  final TextEditingController controller;
  const CustomChatTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: 1,
      maxLines: 5,
      cursorColor: AppColors.primaryColor,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.darkGrey,
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
        suffixIcon: BlocBuilder<SendFileCubit, SendFileState>(
          builder: (context, state) {
            if (state is SendFileLoading) {
              return Padding(
                padding: EdgeInsets.all(12.r),
                child: SizedBox(
                  height: 20.h,
                  width: 20.w,
                  child: const CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                ),
              );
            }
            return IconButton(
              icon: const Icon(Icons.attach_file, color: AppColors.white),
              onPressed: () {
                context.read<SendFileCubit>().chooseFileType();
              },
            );
          },
        ),
      ),
    );
  }
}
