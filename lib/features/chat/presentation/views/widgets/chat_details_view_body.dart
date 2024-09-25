import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/send%20file%20cubit/send_file_cubit.dart';
import 'chat_message_item.dart';
import 'custom_chat_text_field.dart';

class ChatDetailsViewBody extends StatelessWidget {
  static List<Widget> dummyMessages = [
    vGap(12),
    const ChatMessageItem(
      message: "dasdasdasdasddasasdasdasdasdasdasd;ldksd",
      isSender: false,
    ),
    vGap(5),
    const ChatMessageItem(
      message: "dasdasdasdasddasasdasdasdasdasdasd;ldksd",
      isSender: true,
    ),
    vGap(5),
    const ChatMessageItem(
      message: "dasdasdasdasddasasdasdasdasdasdasd;ldksd",
      isSender: true,
    ),
    vGap(5),
    const ChatMessageItem(
      message: "dasdasdasdasddasasdasdasdasdasdasd;ldksd",
      isSender: false,
    ),
    vGap(5),
    const ChatMessageItem(
      message: "dasdasdasdasddasasdasdasdasdasdasd;ldksd",
      isSender: true,
    ),
    vGap(5),
    const ChatMessageItem(
      message: "dasdasdasdasddasasdasdasdasdasdasd;ldksd",
      isSender: false,
    ),
    vGap(5),
    const ChatMessageItem(
      message: "dasdasdasdasddasasdasdasdasdasdasd;ldksd",
      isSender: false,
    ),
    vGap(5),
    const ChatMessageItem(
      message: "dasdasdasdasddasasdasdasdasdasdasd;ldksd",
      isSender: false,
    ),
  ];
  const ChatDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: dummyMessages,
            ),
          ),
          vGap(5),
          BlocBuilder<SendFileCubit, SendFileState>(builder: (context, state) {
            // if (state is SendFilePicked) {
            //   return PickedFileWidget(
            //     user: widget.user,
            //   );
            // } else {
            return const CustomChatTextField();
          }
              // },
              ),
          vGap(5),
        ],
      ),
    );
  }
}
