enum GeneralStateType {
  serious,
  regular,
}

extension GeneralStateTypeExtension on GeneralStateType {
  String get label {
    switch (this) {
      case GeneralStateType.serious:
        return 'Grave';
      case GeneralStateType.regular:
        return 'Regular';
    }
  }

  String get toJson {
    switch (this) {
      case GeneralStateType.serious:
        return 'grave';
      case GeneralStateType.regular:
        return 'regular';
    }
  }
}

GeneralStateType? generalStateFromjson(String? type) {
  switch (type) {
    case 'grave':
      return GeneralStateType.serious;
    case 'regular':
      return GeneralStateType.regular;
    default:
      return null;
  }
}
