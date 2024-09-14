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
