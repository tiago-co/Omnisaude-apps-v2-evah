import 'package:omni_general_labels/labels.dart';

enum ProgramType { pharma, operator }

extension ProgramTypeExtension on ProgramType {
  String get label {
    switch (this) {
      case ProgramType.pharma:
        return GeneralLabels.programTypePharma;
      case ProgramType.operator:
        return GeneralLabels.programTypeOperator;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case ProgramType.pharma:
        return 'f';
      case ProgramType.operator:
        return 'o';
      default:
        return null;
    }
  }
}

ProgramType? programTypeFromJson(String? programType) {
  switch (programType) {
    case 'f':
      return ProgramType.pharma;
    case 'o':
      return ProgramType.operator;
    default:
      return null;
  }
}
