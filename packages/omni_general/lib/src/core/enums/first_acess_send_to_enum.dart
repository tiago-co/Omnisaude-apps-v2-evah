enum FirstAcessType {
  whatsApp,
  email,
}

extension FirstAcessTypeTypeExtension on FirstAcessType {
  String get name {
    switch (this) {
      case FirstAcessType.whatsApp:
        return 'whatsapp';
      case FirstAcessType.email:
        return 'email';
    }
  }
}

FirstAcessType? firstAcessTypeFromJson(String? type) {
  switch (type) {
    case 'whatsapp':
      return FirstAcessType.whatsApp;
    case 'email':
      return FirstAcessType.email;
  }
  return null;
}
