import 'package:flutter/material.dart';

import 'chat_inbox_list_tile.dart';

class ChatInboxListView extends StatelessWidget {
  const ChatInboxListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: 10,
      separatorBuilder: (context, index) {
        return Divider(thickness: 1, color: Colors.grey.shade300);
      },
      itemBuilder: (BuildContext context, int index) {
        return const ChatInboxListTile();
      },
    );
  }
}
