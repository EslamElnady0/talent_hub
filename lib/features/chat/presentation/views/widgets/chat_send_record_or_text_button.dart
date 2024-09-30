import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';

class ChatSendRecordOrTextButton extends StatelessWidget {
  final TextEditingController chatController;
  final VoidCallback onTap;
  const ChatSendRecordOrTextButton(
      {super.key, required this.chatController, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.primaryColor,
      radius: 24.r,
      child: StatefulBuilder(
        builder: (context, setState) {
          chatController.addListener(() {
            if (context.mounted) {
              chatController.text.isNotEmpty
                  ? setState(() {})
                  : setState(() {});
            }
          });
          return GestureDetector(
            onTap: onTap,
            child: Icon(
              chatController.text.isNotEmpty ? Icons.send : Icons.mic,
              color: AppColors.white,
            ),
          );
        },
      ),
    );
  }
}
