enum LungExpansionType {
  symmetric,
  asymmetric,
}

extension LungExpansionExtension on LungExpansionType {
  String get label {
    switch (this) {
      case LungExpansionType.symmetric:
        return 'Simétrica';
      case LungExpansionType.asymmetric:
        return 'Assimétrica';
    }
  }

  String get toJson {
    switch (this) {
      case LungExpansionType.symmetric:
        return 'simetrica';
      case LungExpansionType.asymmetric:
        return 'assimetrica';
    }
  }
}

LungExpansionType? lungExpansionFromJson(String? type) {
  switch (type) {
    case 'simetrica':
      return LungExpansionType.symmetric;
    case 'assimetrica':
      return LungExpansionType.asymmetric;
    default:
      return null;
  }
}
