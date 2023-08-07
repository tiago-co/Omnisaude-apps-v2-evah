enum RenderViewType { list, grid }

extension RenderViewTypeExtension on RenderViewType {
  String get toJson {
    switch (this) {
      case RenderViewType.list:
        return 'list';
      case RenderViewType.grid:
        return 'grid';
    }
  }
}

RenderViewType renderViewTypeFromJson(String? type) {
  switch (type) {
    case 'list':
      return RenderViewType.list;
    case 'grid':
      return RenderViewType.grid;
    default:
      return RenderViewType.grid;
  }
}
