import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/helpers/format_date_to_hours_and_mins.dart';
import '../../../../../core/models/user_model.dart';
import '../../../data/models/message_model.dart';
import '../../view models/get messages cubit/get_messages_cubit.dart';

class LastMessageStreamBuilder extends StatelessWidget {
  final UserModel user;
  final bool isMessageText;
  const LastMessageStreamBuilder(
      {super.key, required this.user, required this.isMessageText});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MessageModel>(
        stream: context
            .read<GetMessagesCubit>()
            .getLastMessage(receivingUserId: user.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              isMessageText
                  ? snapshot.data!.senderId == user.id
                      ? "${user.name.split(" ").first.trim()} : ${snapshot.data!.message}"
                      : "You : ${snapshot.data!.message}"
                  : formatDateToHoursAndMins(snapshot.data!.createdAt),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            );
          } else {
            return const SizedBox();
          }
        });
  }
}
