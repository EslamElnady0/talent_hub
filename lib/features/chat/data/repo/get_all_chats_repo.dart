import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:talent_hub/core/failure/failure.dart';
import 'package:talent_hub/core/models/user_model.dart';

class GetAllChatsRepo {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  GetAllChatsRepo({required this.firestore, required this.auth});

  Future<Either<Failure, List<UserModel>>> getAllChats() async {
    try {
      List<QueryDocumentSnapshot<Map<String, dynamic>>> usersIds = [];
      await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("chats")
          .get()
          .then((value) {
        for (var element in value.docs) {
          usersIds.add(element);
        }
      });

      List<UserModel> allUserChats = [];
      for (var id in usersIds) {
        await firestore
            .collection("users")
            .where("id", isEqualTo: id.id)
            .get()
            .then((value) {
          for (var element in value.docs) {
            allUserChats.add(UserModel.fromJson(element.data()));
          }
        });
      }
      return right(allUserChats);
    } catch (e) {
      log(e.toString());
      if (e is FirebaseException) {
        return left(FirebaseFailure(e.message.toString()));
      }
      return left(FirebaseFailure(e.toString()));
    }
  }
}
