enum InputType { date, text, number, email }


extension InputTypeExtension on InputType {
  String? get toJson {
    switch (this) {
      case InputType.date:
        return 'date';
      case InputType.text:
        return 'text';
      case InputType.number:
        return 'number';
      case InputType.email:
        return 'email';
      default:
        return null;
    }
  }
}

InputType? inputTypeFromJson(String type) {
  switch (type) {
    case 'date':
      return InputType.date;
    case 'text':
      return InputType.text;
    case 'number':
      return InputType.number;
    case 'email':
      return InputType.email;
    default:
      return null;
  }
}
