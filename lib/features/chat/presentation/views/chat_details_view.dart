import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talent_hub/core/theme/app_colors.dart';

import '../../../../core/theme/app_text_styles.dart';
import 'widgets/chat_details_appbar_leading.dart';
import 'widgets/chat_details_view_body.dart';

class ChatDetailsView extends StatelessWidget {
  const ChatDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 55.w,
        backgroundColor: AppColors.primaryColor,
        leading: const ChatDetailsAppBarLeading(),
        title: Text("User Name", style: AppTextStyles.font20WhiteW600),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: AppColors.white),
          )
        ],
      ),
      body: const ChatDetailsViewBody(),
    );
  }
}
