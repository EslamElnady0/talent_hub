import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String uId;
  String playerId;
  String videoUrl;
  String description;
  DateTime createdAt;
  List<String> likes;
  List<Comment> comments;

  Post({
    required this.uId,
    required this.playerId,
    required this.videoUrl,
    required this.description,
    required this.createdAt,
    this.likes = const [],
    this.comments = const [],
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      uId: map['uId'],
      playerId: map['playerId'],
      videoUrl: map['videoUrl'],
      description: map['description'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      likes: List<String>.from(map['likes'] ?? []),
      comments: List<Comment>.from(map['comments']?.map((comment) => Comment.fromMap(comment)) ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'playerId': playerId,
      'videoUrl': videoUrl,
      'description': description,
      'createdAt': createdAt,
      'likes': likes,
      'comments': comments.map((comment) => comment.toMap()).toList(),
    };
  }
}

class Comment {
  String userId;
  String username;
  String text;
  DateTime commentedAt;

  Comment({
    required this.userId,
    required this.username,
    required this.text,
    required this.commentedAt,
  });

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      userId: map['userId'] ?? '',
      username: map['username'] ?? '',
      text: map['text'] ?? '',
      commentedAt: (map['commentedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'text': text,
      'commentedAt': commentedAt,
    };
  }
}
