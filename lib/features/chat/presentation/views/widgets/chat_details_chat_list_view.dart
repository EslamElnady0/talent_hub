import 'package:flutter/material.dart';

import '../../../../../core/helpers/spacing.dart';
import 'chat_message_item.dart';

class ChatDetailsChatListView extends StatelessWidget {
  const ChatDetailsChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) => const ChatMessageItem(
                message: "dasdasdasdasddasasdasdasdasdasdasd;ldksd",
                isSender: false,
              ),
          separatorBuilder: (context, index) => vGap(5),
          itemCount: 10),
    );
  }
}
