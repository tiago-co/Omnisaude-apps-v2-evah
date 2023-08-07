import 'package:omni_general_labels/labels.dart';

enum BloodType { a1, a2, b1, b2, ab1, ab2, o1, o2 }

extension BloodTypeExtension on BloodType {
  String get label {
    switch (this) {
      case BloodType.a1:
        return GeneralLabels.bloodTypeAPlus;
      case BloodType.a2:
        return GeneralLabels.bloodTypeAMinus;
      case BloodType.b1:
        return GeneralLabels.bloodTypeBPlus;
      case BloodType.b2:
        return GeneralLabels.bloodTypeBMinus;
      case BloodType.ab1:
        return GeneralLabels.bloodTypeABPlus;
      case BloodType.ab2:
        return GeneralLabels.bloodTypeABMinus;
      case BloodType.o1:
        return GeneralLabels.bloodTypeOPlus;
      case BloodType.o2:
        return GeneralLabels.bloodTypeOMinus;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case BloodType.a1:
        return 'A+';
      case BloodType.a2:
        return 'A-';
      case BloodType.b1:
        return 'B+';
      case BloodType.b2:
        return 'B-';
      case BloodType.ab1:
        return 'AB+';
      case BloodType.ab2:
        return 'AB-';
      case BloodType.o1:
        return 'O+';
      case BloodType.o2:
        return 'O-';
      default:
        return null;
    }
  }
}

BloodType? bloodTypeFromJson(String? bloodType) {
  switch (bloodType) {
    case 'A+':
      return BloodType.a1;
    case 'A-':
      return BloodType.a2;
    case 'B+':
      return BloodType.b1;
    case 'B-':
      return BloodType.b2;
    case 'AB+':
      return BloodType.ab1;
    case 'AB-':
      return BloodType.ab2;
    case 'O+':
      return BloodType.o1;
    case 'O-':
      return BloodType.o2;
    default:
      return null;
  }
}
