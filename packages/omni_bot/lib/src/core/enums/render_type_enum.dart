enum RenderType { list, search, radio }


extension RenderTypeExtension on RenderType {
  String? get toJson {
    switch (this) {
      case RenderType.list:
        return 'list';
      case RenderType.search:
        return 'search';
      case RenderType.radio:
        return 'search';
      default:
        return null;
    }
  }
}

RenderType? renderTypeFromJson(String? type) {
  switch (type) {
    case 'list':
      return RenderType.list;
    case 'search':
      return RenderType.search;
    case 'radio':
      return RenderType.radio;
    default:
      return null;
  }
}
