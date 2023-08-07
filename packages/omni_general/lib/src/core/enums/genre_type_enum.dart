import 'package:omni_general_labels/labels.dart';

enum GenreType { male, female, other }

extension GenreTypeExtension on GenreType {
  String get label {
    switch (this) {
      case GenreType.male:
        return GeneralLabels.genreTypeMale;
      case GenreType.female:
        return GeneralLabels.genreTypeFemale;
      case GenreType.other:
        return GeneralLabels.genreTypeOther;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case GenreType.male:
        return 'm';
      case GenreType.female:
        return 'f';
      case GenreType.other:
        return 'o';
      default:
        return null;
    }
  }
}

GenreType? genreTypeFromJson(String? programType) {
  switch (programType) {
    case 'm':
      return GenreType.male;
    case 'f':
      return GenreType.female;
    case 'o':
      return GenreType.other;
    case 'M':
      return GenreType.male;
    case 'F':
      return GenreType.female;
    case 'O':
      return GenreType.other;
    default:
      return null;
  }
}
