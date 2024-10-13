import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/features/chat/presentation/views/widgets/chat_inbox_list_view.dart';

import '../../../../../core/theme/app_text_styles.dart';

class ChatInboxViewBody extends StatelessWidget {
  const ChatInboxViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          vGap(12),
          Text(
            "here you can see all your chats",
            textAlign: TextAlign.center,
            style: AppTextStyles.font14greyW400,
          ),
          vGap(12),
          const Expanded(child: ChatInboxListView()),
        ],
      ),
    );
  }
}
