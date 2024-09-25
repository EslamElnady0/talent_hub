import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20file%20cubit/send_file_cubit.dart';
import 'package:talent_hub/main.dart';
import 'package:uuid/uuid.dart';
import '../../../../../core/DI/dependency_injection.dart';
import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/message_model.dart';

class PickedFileWidget extends StatelessWidget {
  const PickedFileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: AppColors.darkGrey),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              vGap(10),
              Row(children: [
                IconButton(
                  onPressed: () async {
                    String messageId = const Uuid().v1();
                    if (context.read<SendFileCubit>().fileType.name ==
                        MessageType.image.name) {
                      MessageModel imageMessage = MessageModel(
                          senderId: getIt.get<FirebaseAuth>().currentUser!.uid,
                          receiverId: receiver,
                          message: "",
                          messageType: context
                                      .read<SendFileCubit>()
                                      .fileType
                                      .name ==
                                  MessageType.image.name
                              ? MessageType.image
                              : context.read<SendFileCubit>().fileType.name ==
                                      MessageType.video.name
                                  ? MessageType.video
                                  : MessageType.file,
                          createdAt: DateTime.now(),
                          textMessageId: messageId);

                      if (context.mounted) {
                        context.read<SendFileCubit>().sendFile(
                            fileMessage: imageMessage,
                            receivingUserId: receiver);
                        context.read<SendFileCubit>().filePath = null;
                        context.read<SendFileCubit>().fileType =
                            MessageType.text;
                      }
                    }
                  },
                  icon: Transform.rotate(
                    angle: 3.14,
                    child: const Icon(
                      Icons.send,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    context.read<SendFileCubit>().dismissPickedFile();
                  },
                  icon: const Icon(Icons.delete),
                  color: AppColors.red,
                )
              ])
            ],
          ),
        ),
      ],
    );
  }
}
