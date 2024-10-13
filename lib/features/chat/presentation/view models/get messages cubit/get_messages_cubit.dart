import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:talent_hub/core/DI/dependency_injection.dart';
import 'package:talent_hub/features/chat/data/repo/get_messages_repo.dart';

import '../../../data/models/message_model.dart';

part 'get_messages_state.dart';

class GetMessagesCubit extends Cubit<GetMessagesState> {
  GetMessagesCubit(this.getMessagesRepo) : super(GetMessagesInitial());
  final GetMessagesRepo getMessagesRepo;
  late ScrollController scrollController;

  Stream<List<MessageModel>> getAllMessages({required String receivingUserId}) {
    try {
      return getIt
          .get<FirebaseFirestore>()
          .collection('users')
          .doc(getIt.get<FirebaseAuth>().currentUser!.uid)
          .collection('chats')
          .doc(receivingUserId)
          .collection('messages')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((event) {
        WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
        return event.docs.map((e) => MessageModel.fromMap(e.data())).toList();
      });
    } catch (e) {
      log(e.toString());
      return Stream.value([]);
    }
  }

  scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  Stream<MessageModel> getLastMessage({required String receivingUserId}) {
    try {
      return getIt
          .get<FirebaseFirestore>()
          .collection('users')
          .doc(getIt.get<FirebaseAuth>().currentUser!.uid)
          .collection('chats')
          .doc(receivingUserId)
          .collection('messages')
          .orderBy('createdAt')
          .limitToLast(1)
          .snapshots()
          .map((event) {
        return event.docs.map((e) => MessageModel.fromMap(e.data())).first;
      });
    } catch (e) {
      log(e.toString());
      return Stream.value(MessageModel.empty());
    }
  }
}
