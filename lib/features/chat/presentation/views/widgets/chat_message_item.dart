import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/helpers/format_date_to_hours_and_mins.dart';
import 'package:talent_hub/core/theme/app_colors.dart';
import 'package:talent_hub/features/chat/data/models/message_model.dart';

import '../../../../../core/theme/app_text_styles.dart';
import 'custom_file_message_widget.dart';
import 'custom_image_message_widget.dart';
import 'custom_video_message_widget.dart';
import 'custom_voice_message_widget.dart';

class ChatMessageItem extends StatelessWidget {
  final MessageModel message;
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
              switch (message.messageType) {
                MessageType.text => Text(
                    message.message.toString(),
                    style: AppTextStyles.font15WhiteW500,
                  ),
                MessageType.image => CustomImageMessageWidget(
                    imagePath: message.message.toString(),
                  ),
                MessageType.voice => CustomVoiceMessageWidget(
                    voiceMessagePath: message.message.toString()),
                MessageType.file => CustomFileMessageWidget(
                    fileUrl: message.message.toString(),
                  ),
                MessageType.video => CustomVideoMessageWidget(
                    videoUrl: message.message.toString(),
                  ),
              },
              Text(formatDateToHoursAndMins(message.createdAt),
                  style: AppTextStyles.font12WhiteW500),
            ],
          ),
        ),
      ),
    );
  }
}
