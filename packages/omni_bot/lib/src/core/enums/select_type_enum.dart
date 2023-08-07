enum SelectType { horizontal, slide, vertical }


extension SelectTypeExtension on SelectType {
  String? get toJson {
    switch (this) {
      case SelectType.horizontal:
        return 'horizontal';
      case SelectType.slide:
        return 'slide';
      case SelectType.vertical:
        return 'vertical';
      default:
        return null;
    }
  }
}

SelectType? selectTypeFromJson(String? type) {
  switch (type) {
    case 'horizontal':
      return SelectType.horizontal;
    case 'slide':
      return SelectType.slide;
    case 'vertical':
      return SelectType.vertical;
    default:
      return null;
  }
}
