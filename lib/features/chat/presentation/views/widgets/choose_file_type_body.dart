import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20file%20cubit/send_file_cubit.dart';

class ChooseFileTypeBody extends StatelessWidget {
  const ChooseFileTypeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: AppColors.darkGrey),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    context.read<SendFileCubit>().pickImageFromCamera();
                  },
                  icon: Icon(
                    Icons.camera_alt_rounded,
                    size: 24.r,
                    color: AppColors.primaryColor,
                  )),
              IconButton(
                  onPressed: () {
                    context.read<SendFileCubit>().pickImageFromGallery();
                  },
                  icon: Icon(
                    Icons.image_rounded,
                    size: 24.r,
                    color: AppColors.primaryColor,
                  )),
              IconButton(
                  onPressed: () {
                    context.read<SendFileCubit>().pickVideo(context);
                  },
                  icon: Icon(
                    Icons.videocam_rounded,
                    size: 24.r,
                    color: AppColors.primaryColor,
                  )),
              IconButton(
                  onPressed: () {
                    context.read<SendFileCubit>().pickFile();
                  },
                  icon: Icon(
                    Icons.insert_drive_file_rounded,
                    size: 24.r,
                    color: AppColors.primaryColor,
                  )),
              IconButton(
                  onPressed: () {
                    context.read<SendFileCubit>().dismissPickedFile();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 24.r,
                    color: AppColors.primaryColor,
                  )),
            ],
          ),
        ));
  }
}
