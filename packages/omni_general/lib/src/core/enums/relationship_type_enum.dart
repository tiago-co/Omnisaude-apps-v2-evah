import 'package:omni_general_labels/labels.dart';

enum RelationshipType {
  father,
  mother,
  grandPa,
  grandMa,
  uncle,
  aunt,
  maleCousin,
  femaleCousin,
  brother,
  sister,
  other,
}

extension RelationshipTypeExtension on RelationshipType {
  String get label {
    switch (this) {
      case RelationshipType.father:
        return GeneralLabels.relationshipTypeFather;
      case RelationshipType.mother:
        return GeneralLabels.relationshipTypeMother;
      case RelationshipType.grandPa:
        return GeneralLabels.relationshipTypeGrandPa;
      case RelationshipType.grandMa:
        return GeneralLabels.relationshipTypeGrandMa;
      case RelationshipType.uncle:
        return GeneralLabels.relationshipTypeUncle;
      case RelationshipType.aunt:
        return GeneralLabels.relationshipTypeAunt;
      case RelationshipType.maleCousin:
        return GeneralLabels.relationshipTypeMaleCousin;
      case RelationshipType.femaleCousin:
        return GeneralLabels.relationshipTypeFemaleCousin;
      case RelationshipType.brother:
        return GeneralLabels.relationshipTypeBrother;
      case RelationshipType.sister:
        return GeneralLabels.relationshipTypeSister;
      case RelationshipType.other:
        return GeneralLabels.relationshipTypeOther;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case RelationshipType.father:
        return 'pai';
      case RelationshipType.mother:
        return 'mae';
      case RelationshipType.grandPa:
        return 'avô';
      case RelationshipType.grandMa:
        return 'avó';
      case RelationshipType.uncle:
        return 'tio';
      case RelationshipType.aunt:
        return 'tia';
      case RelationshipType.maleCousin:
        return 'primo';
      case RelationshipType.femaleCousin:
        return 'prima';
      case RelationshipType.brother:
        return 'irmao';
      case RelationshipType.sister:
        return 'irma';
      case RelationshipType.other:
        return 'outro';
      default:
        return null;
    }
  }
}

RelationshipType? relationshipTypeFromJson(String type) {
  switch (type) {
    case 'pai':
      return RelationshipType.father;
    case 'mae':
      return RelationshipType.mother;
    case 'avô':
      return RelationshipType.grandPa;
    case 'avó':
      return RelationshipType.grandMa;
    case 'tio':
      return RelationshipType.uncle;
    case 'tia':
      return RelationshipType.aunt;
    case 'primo':
      return RelationshipType.maleCousin;
    case 'prima':
      return RelationshipType.femaleCousin;
    case 'irmao':
      return RelationshipType.brother;
    case 'irma':
      return RelationshipType.sister;
    case 'outro':
      return RelationshipType.other;
    default:
      return null;
  }
}
