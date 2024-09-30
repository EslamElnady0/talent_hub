import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20file%20cubit/send_file_cubit.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/models/message_model.dart';

class PickedFileViewWidget extends StatelessWidget {
  const PickedFileViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return context.read<SendFileCubit>().fileType.name == MessageType.image.name
        ? Image.file(
            File(
              context.read<SendFileCubit>().filePath!,
            ),
            height: 70.h,
          )
        : context.read<SendFileCubit>().fileType.name == MessageType.video.name
            ? Stack(
                alignment: Alignment.center,
                children: [
                  Image.memory(
                    context.read<SendFileCubit>().videoThumbnail!,
                    height: 70.h,
                  ),
                  Icon(Icons.play_arrow, size: 30.r, color: AppColors.white)
                ],
              )
            : Align(
                alignment: Alignment.center,
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.insert_drive_file_rounded,
                        size: 30.r,
                        color: AppColors.primaryColor,
                      ),
                      hGap(10),
                      Text(
                        context.read<SendFileCubit>().filePath!.split('/').last,
                        style: AppTextStyles.font15WhiteW500,
                      )
                    ],
                  ),
                ),
              );
  }
}
