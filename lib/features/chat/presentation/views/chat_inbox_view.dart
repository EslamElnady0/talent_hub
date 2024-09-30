import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/DI/dependency_injection.dart';
import 'package:talent_hub/core/theme/app_text_styles.dart';
import 'package:talent_hub/features/chat/presentation/view%20models/get%20all%20chats%20cubit/get_all_chats_cubit.dart';

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
      body: BlocProvider(
        create: (context) => getIt<GetAllChatsCubit>(),
        child: const ChatInboxViewBody(),
      ),
    );
  }
}
