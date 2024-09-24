import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:record/record.dart';
import 'package:talent_hub/core/utils/send%20files%20utils/send_file_message.dart';
import '../../../../core/models/user_model.dart';
import '../models/message_model.dart';

class SendMessageRepo {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  SendMessageRepo(
      {required this.auth, required this.firestore, required this.storage});
  Future<void> sendTextMessage(
      {required MessageModel message, required UserModel receivingUser}) async {
    await firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(receivingUser.id)
        .collection("messages")
        .doc(message.textMessageId)
        .set(message.toMap());
    await firestore
        .collection("users")
        .doc(receivingUser.id)
        .collection("chats")
        .doc(auth.currentUser!.uid)
        .collection("messages")
        .doc(message.textMessageId)
        .set(message.toMap());
  }

  Future<void> sendRecord(
      {required MessageModel voiceMessage,
      required AudioRecorder audioRecorder,
      required UserModel receivingUser}) async {
    String? filePath = await audioRecorder.stop();
    if (filePath != null) {
      log(filePath);
      String fileUrl = await sendFileMessage(
          message: voiceMessage,
          file: File(filePath),
          receivingUser: receivingUser);
      voiceMessage.message = fileUrl;
      sendTextMessage(message: voiceMessage, receivingUser: receivingUser);
    }
  }

  sendImage(
      {required MessageModel imageMessage,
      required UserModel receivingUser,
      required String? imagePath}) async {
    String fileUrl = await sendFileMessage(
        message: imageMessage,
        file: File(imagePath!),
        receivingUser: receivingUser);
    imageMessage.message = fileUrl;
    sendTextMessage(message: imageMessage, receivingUser: receivingUser);
  }

  sendFile(
      {required MessageModel fileMessage,
      required UserModel receivingUser,
      required String? pickedFilePath}) async {
    String fileUrl = await sendFileMessage(
        message: fileMessage,
        file: File(pickedFilePath!),
        receivingUser: receivingUser);
    fileMessage.message = fileUrl;
    sendTextMessage(message: fileMessage, receivingUser: receivingUser);
  }

  sendVideo(
      {required MessageModel videoMessage,
      required UserModel receivingUser,
      required String? videoPath}) async {
    String fileUrl = await sendFileMessage(
        message: videoMessage,
        file: File(videoPath!),
        receivingUser: receivingUser);
    videoMessage.message = fileUrl;
    sendTextMessage(message: videoMessage, receivingUser: receivingUser);
  }
}
