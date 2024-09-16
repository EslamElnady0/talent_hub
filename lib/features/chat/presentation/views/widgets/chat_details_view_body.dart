import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/helpers/spacing.dart';

import 'chat_details_chat_list_view.dart';

class ChatDetailsViewBody extends StatelessWidget {
  const ChatDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          vGap(12),
          const ChatDetailsChatListView(),
        ],
      ),
    );
  }
}
