import 'package:flutter/material.dart';
import 'package:talent_hub/core/theme/app_text_styles.dart';

import 'widgets/chat_inbox_view_body.dart';

class ChatInboxView extends StatelessWidget {
  const ChatInboxView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //chats or incomming
        title: Text(
          "Chats",
          style: AppTextStyles.font20DarkW600,
        ),
        centerTitle: true,
      ),
      body: const ChatInboxViewBody(),
    );
  }
}
