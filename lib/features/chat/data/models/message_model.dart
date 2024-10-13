class MessageModel {
  final String senderId;
  final String receiverId;
  String? message;
  final MessageType messageType;
  final DateTime createdAt;
  final String textMessageId;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.messageType,
    required this.createdAt,
    required this.textMessageId,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'messageType': messageType.type,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'textMessageId': textMessageId,
    };
  }

  factory MessageModel.empty() {
    return MessageModel(
      senderId: "",
      receiverId: "",
      message: "",
      messageType: MessageType.text,
      createdAt: DateTime.now(),
      textMessageId: "",
    );
  }
  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      message: map['message'],
      messageType: (map["messageType"] as String).toEnum(),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map["createdAt"]),
      textMessageId: map['textMessageId'],
    );
  }
}

enum MessageType {
  text("text"),
  video("video"),
  voice("voice"),
  image("image"),
  file("file");

  final String type;
  const MessageType(this.type);
}

extension ConvertMessageType on String {
  MessageType toEnum() {
    switch (this) {
      case "text":
        return MessageType.text;
      case "video":
        return MessageType.video;
      case "voice":
        return MessageType.voice;
      case "image":
        return MessageType.image;
      case "file":
        return MessageType.file;
      default:
        return MessageType.text;
    }
  }
}
