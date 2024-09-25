import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:record/record.dart';
import 'package:talent_hub/core/utils/send%20messages%20utils/send_file_message.dart';
import '../models/message_model.dart';

class SendMessageRepo {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  SendMessageRepo(
      {required this.auth, required this.firestore, required this.storage});
  Future<bool?> sendTextMessage(
      {required MessageModel message, required String receivingUserId}) async {
    try {
      await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("chats")
          .doc(receivingUserId)
          .collection("messages")
          .doc(message.textMessageId)
          .set(message.toMap());
      await firestore
          .collection("users")
          .doc(auth.currentUser!.uid)
          .collection("chats")
          .doc(receivingUserId)
          .set({"field": "value"});
      await firestore
          .collection("users")
          .doc(receivingUserId)
          .collection("chats")
          .doc(auth.currentUser!.uid)
          .collection("messages")
          .doc(message.textMessageId)
          .set(message.toMap());
      await firestore
          .collection("users")
          .doc(receivingUserId)
          .collection("chats")
          .doc(auth.currentUser!.uid)
          .set({"field": "value"});
      return true;
    } catch (e) {
      log("error in sending message $e");
      return null;
    }
  }

  Future<bool?> sendRecord(
      {required MessageModel voiceMessage,
      required AudioRecorder audioRecorder,
      required String receivingUserId}) async {
    try {
      String? filePath = await audioRecorder.stop();
      if (filePath != null) {
        log(filePath);
        String fileUrl = await sendFileMessage(
          message: voiceMessage,
          file: File(filePath),
        );
        voiceMessage.message = fileUrl;
        sendTextMessage(
            message: voiceMessage, receivingUserId: receivingUserId);
      }
      return true;
    } catch (e) {
      log("error in recording $e");
      return null;
    }
  }

  Future<bool?> sendImage(
      {required MessageModel imageMessage,
      required String receivingUserId,
      required String? imagePath}) async {
    try {
      String fileUrl = await sendFileMessage(
        message: imageMessage,
        file: File(imagePath!),
      );
      imageMessage.message = fileUrl;
      sendTextMessage(message: imageMessage, receivingUserId: receivingUserId);
      return true;
    } catch (e) {
      log("error in sending image $e");
      return null;
    }
  }

  Future<bool?> sendFile(
      {required MessageModel fileMessage,
      required String receivingUserId,
      required String? pickedFilePath}) async {
    try {
      String fileUrl = await sendFileMessage(
        message: fileMessage,
        file: File(pickedFilePath!),
      );
      fileMessage.message = fileUrl;
      sendTextMessage(message: fileMessage, receivingUserId: receivingUserId);
      return true;
    } catch (e) {
      log("error in sending file $e");
      return null;
    }
  }

  Future<bool?> sendVideo(
      {required MessageModel videoMessage,
      required String receivingUserId,
      required String? videoPath}) async {
    try {
      String fileUrl = await sendFileMessage(
        message: videoMessage,
        file: File(videoPath!),
      );
      videoMessage.message = fileUrl;
      sendTextMessage(message: videoMessage, receivingUserId: receivingUserId);
      return true;
    } catch (e) {
      log("error in sending video $e");
      return null;
    }
  }
}
