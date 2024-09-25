import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talent_hub/core/helpers/spacing.dart';
import 'package:talent_hub/features/chat/presentation/views/widgets/chat_message_item.dart';
import 'package:talent_hub/main.dart';

import '../../../../../core/DI/dependency_injection.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../data/models/message_model.dart';
import '../../view models/get messages cubit/get_messages_cubit.dart';

class ChatDetailsChatListView extends StatelessWidget {
  const ChatDetailsChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: StreamBuilder<List<MessageModel>?>(
            stream: context
                .read<GetMessagesCubit>()
                .getAllMessages(receivingUserId: receiver),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                ));
              }
              return BlocBuilder<GetMessagesCubit, GetMessagesState>(
                builder: (context, state) {
                  if (snapshot.data!.isEmpty) {
                    return Center(
                        child: Text(
                      "No messages yet",
                      style: AppTextStyles.font15WhiteW500
                          .copyWith(color: AppColors.black),
                    ));
                  } else if (snapshot.data!.isNotEmpty) {
                    return ListView.separated(
                      controller:
                          context.read<GetMessagesCubit>().scrollController,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return ChatMessageItem(
                          message: snapshot.data![index],
                          isSender: snapshot.data![index].senderId ==
                              getIt.get<FirebaseAuth>().currentUser!.uid,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return vGap(10);
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("idk"),
                    );
                  }
                },
              );
            }));
  }
}
