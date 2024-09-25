import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:talent_hub/features/chat/data/repo/get_messages_repo.dart';

import '../../../data/models/message_model.dart';

part 'get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  GetMessagesCubit(this.getMessagesRepo) : super(GetMessagesInitial());
  final GetMessagesRepo getMessagesRepo;
  final ScrollController scrollController = ScrollController();

  Stream<List<MessageModel>?> getAllMessages(
      {required String receivingUserId}) {
    return getMessagesRepo
        .getAllMessages(
            receivingUserId: receivingUserId,
            scrollToBottom: () {
              scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn);
            })
        .map((event) {
      return event;
    });
  }
}
