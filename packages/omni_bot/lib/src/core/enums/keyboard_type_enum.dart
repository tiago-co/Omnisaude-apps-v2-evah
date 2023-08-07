enum KeyboardType { date, email, number, text }


extension KeyboardTypeExtension on KeyboardType {
  String? get toJson {
    switch (this) {
      case KeyboardType.date:
        return 'date';
      case KeyboardType.text:
        return 'text';
      case KeyboardType.number:
        return 'number';
      case KeyboardType.email:
        return 'email';
      default:
        return null;
    }
  }
}

KeyboardType? keyboardTypeFromJson(String type) {
  switch (type) {
    case 'date':
      return KeyboardType.date;
    case 'text':
      return KeyboardType.text;
    case 'number':
      return KeyboardType.number;
    case 'email':
      return KeyboardType.email;
    default:
      return null;
  }
}
