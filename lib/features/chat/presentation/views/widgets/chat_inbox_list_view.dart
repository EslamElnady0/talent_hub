import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/theme/app_text_styles.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/get%20all%20chats%20cubit/get_all_chats_cubit.dart';

import '../../../../../core/theme/app_colors.dart';
import 'chat_inbox_list_tile.dart';

class ChatInboxListView extends StatefulWidget {
  const ChatInboxListView({super.key});

  @override
  State<ChatInboxListView> createState() => _ChatInboxListViewState();
}

class _ChatInboxListViewState extends State<ChatInboxListView> {
  @override
  void initState() {
    context.read<GetAllChatsCubit>().getAllChats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetAllChatsCubit, GetAllChatsState>(
      builder: (context, state) {
        if (state is GetAllChatsSuccess) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: state.users.length,
            separatorBuilder: (context, index) {
              return Divider(thickness: 1, color: Colors.grey.shade300);
            },
            itemBuilder: (BuildContext context, int index) {
              return ChatInboxListTile(
                user: state.users[index],
              );
            },
          );
        } else if (state is GetAllChatsLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.primaryColor,
          ));
        } else {
          return Center(
            child: Text(
              "No chats yet",
              style: AppTextStyles.font16DarkW600,
            ),
          );
        }
      },
    );
  }
}
