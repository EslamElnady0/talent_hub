import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20record%20cubit/send_record_cubit.dart';
import 'package:talent_hub/main.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/models/message_model.dart';

class RecordingMessageBody extends StatefulWidget {
  const RecordingMessageBody({
    super.key,
  });

  @override
  State<RecordingMessageBody> createState() => _RecordingMessageBodyState();
}

class _RecordingMessageBodyState extends State<RecordingMessageBody> {
  late Timer timer;
  int recodringTime = 0;
  Duration duration = const Duration();
  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      duration = Duration(seconds: recodringTime);

      setState(() {
        recodringTime++;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 1.r,
      ),
      decoration: BoxDecoration(
          color: AppColors.darkGrey, borderRadius: BorderRadius.circular(16.r)),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                context.read<SendRecordCubit>().stopRecording();
              },
              icon: Icon(
                Icons.delete,
                size: 27.r,
                color: AppColors.red,
              )),
          const Spacer(),
          Text(
            "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
            style: AppTextStyles.font16DarkW600.copyWith(color: Colors.white),
          ),
          const Spacer(),
          IconButton(
              onPressed: () {
                String messageId = const Uuid().v1();
                MessageModel voiceMessage = MessageModel(
                    senderId: sender,
                    receiverId: receiver,
                    message: "",
                    messageType: MessageType.voice,
                    createdAt: DateTime.now(),
                    textMessageId: messageId);

                if (context.mounted) {
                  context.read<SendRecordCubit>().sendRecord(
                        voiceMessage: voiceMessage,
                        receivingUserId: receiver,
                      );
                }
              },
              icon: Icon(
                Icons.send,
                size: 27.r,
                color: AppColors.primaryColor,
              )),
        ],
      ),
    );
  }
}
