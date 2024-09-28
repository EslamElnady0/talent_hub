import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String uId;
  String name;
  String? imageUrl;
  String videoUrl;
  String text;
  Timestamp date;
  String postId;

  PostModel({
    required this.uId,
    required this.postId,
    required this.name,
    required this.videoUrl,
    required this.text,
    required this.date,
    this.imageUrl,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      uId: json['uId'] as String,
      postId: json['postId'] as String,
      name: json['name'] as String,
      videoUrl: json['videoUrl'] as String,
      text: json['description'] as String,
      date: json['createdAt'] as Timestamp,
      imageUrl: json['imageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'postId': postId,
      'name': name,
      'videoUrl': videoUrl,
      'description': text,
      'createdAt': date,
      'imageUrl': imageUrl,
    };
  }
}
