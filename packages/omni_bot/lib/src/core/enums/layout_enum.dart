enum Layout { avatarCard, button, card, imageCard }

extension LayoutTypeExtension on Layout {
  String get toJson {
    switch (this) {
      case Layout.avatarCard:
        return 'avatar_card';
      case Layout.button:
        return 'button';
      case Layout.card:
        return 'card';
      case Layout.imageCard:
        return 'image_card';
      default:
        return toString();
    }
  }
}

Layout? layoutFromJson(String? type) {
  switch (type) {
    case 'avatar_card':
      return Layout.avatarCard;
    case 'button':
      return Layout.button;
    case 'card':
      return Layout.card;
    case 'image_card':
      return Layout.imageCard;
    default:
      return null;
  }
}
