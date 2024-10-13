import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/message_model.dart';

class GetMessagesRepo {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  GetMessagesRepo({required this.firestore, required this.auth});

  Stream<List<MessageModel>?> getAllMessages(
      {required String receivingUserId, required VoidCallback scrollToBottom}) {
    try {
      return firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .collection('chats')
          .doc(receivingUserId)
          .collection('messages')
          .orderBy('createdAt')
          .snapshots()
          .map((event) {
        WidgetsBinding.instance.addPostFrameCallback((_) => scrollToBottom());
        return event.docs.map((e) => MessageModel.fromMap(e.data())).toList();
      });
    } catch (e) {
      log(e.toString());
      return Stream.value(null);
    }
  }
}
