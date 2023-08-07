import 'package:omni_general_labels/labels.dart';

enum EthnicityType { white, black, brown, indigenous, yellow }

extension EthnicityTypeExtension on EthnicityType {
  String get label {
    switch (this) {
      case EthnicityType.white:
        return GeneralLabels.ethnicityTypeWhite;
      case EthnicityType.black:
        return GeneralLabels.ethnicityTypeBlack;
      case EthnicityType.brown:
        return GeneralLabels.ethnicityTypeBrown;
      case EthnicityType.indigenous:
        return GeneralLabels.ethnicityTypeIndigenuous;
      case EthnicityType.yellow:
        return GeneralLabels.ethnicityTypeYellow;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case EthnicityType.white:
        return 'w';
      case EthnicityType.black:
        return 'b';
      case EthnicityType.brown:
        return 'p';
      case EthnicityType.indigenous:
        return 'i';
      case EthnicityType.yellow:
        return 'y';
      default:
        return null;
    }
  }
}

EthnicityType? ethnicityTypeFromJson(String? ethnicityType) {
  switch (ethnicityType) {
    case 'w':
      return EthnicityType.white;
    case 'b':
      return EthnicityType.black;
    case 'p':
      return EthnicityType.brown;
    case 'i':
      return EthnicityType.indigenous;
    case 'y':
      return EthnicityType.yellow;
    default:
      return null;
  }
}
