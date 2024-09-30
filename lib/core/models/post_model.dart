import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String uId;
  String name;
  String? imageUrl;
  String videoUrl;
  String text;
  Timestamp createdAt;
  String postId;
  List likes;

  PostModel({
    required this.uId,
    required this.postId,
    required this.name,
    required this.videoUrl,
    required this.text,
    required this.createdAt,
    required this.likes,
    this.imageUrl,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      log("key: $key value: $value");
    });
    return PostModel(
      uId: json['uId'] as String,
      postId: json['postId'] as String,
      name: json['name'] as String,
      videoUrl: json['videoUrl'] as String,
      text: json['text'] as String,
      createdAt: json['createdAt'] as Timestamp,
      imageUrl: json['imageUrl'] as String?,
      likes: json['likes'] as List,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'postId': postId,
      'name': name,
      'videoUrl': videoUrl,
      'text': text,
      'createdAt': createdAt,
      'imageUrl': imageUrl,
      'likes': likes,
    };
  }
}
