enum HomeLayoutType { list, grid, expansive }

extension HomeLayoutTypeExtension on HomeLayoutType {
  String? get toJson {
    switch (this) {
      case HomeLayoutType.list:
        return 'lista';
      case HomeLayoutType.grid:
        return 'grid';
      case HomeLayoutType.expansive:
        return 'expansivo';
    }
  }
}

HomeLayoutType? homeLayoutTypeFromJson(String? homeLayout) {
  switch (homeLayout) {
    case 'lista':
      return HomeLayoutType.list;
    case 'grid':
      return HomeLayoutType.grid;
    case 'expansivo':
      return HomeLayoutType.expansive;
    default:
      return HomeLayoutType.expansive;
  }
}
