enum MessageType { html, image, text }

extension MessageTypeExtension on MessageType {
  String? get toJson {
    switch (this) {
      case MessageType.html:
        return 'html';
      case MessageType.image:
        return 'image';
      case MessageType.text:
        return 'text';
      default:
        return null;
    }
  }
}

MessageType? messageTypeFromJson(String type) {
  switch (type) {
    case 'html':
      return MessageType.html;
    case 'image':
      return MessageType.image;
    case 'text':
      return MessageType.text;
    default:
      return null;
  }
}
