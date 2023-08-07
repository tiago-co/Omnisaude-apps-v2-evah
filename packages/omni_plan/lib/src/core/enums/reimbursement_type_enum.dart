import 'package:reimbursement_labels/labels.dart';

enum ReimbursementType { exam, consultation, surgery, others }

extension ReimbursementTypeExtension on ReimbursementType {
  String get label {
    switch (this) {
      case ReimbursementType.exam:
        return ReimbursementLabels.reimbursementTypeExam;
      case ReimbursementType.consultation:
        return ReimbursementLabels.reimbursementTypeConsultation;
      case ReimbursementType.surgery:
        return ReimbursementLabels.reimbursementTypeSurgery;
      case ReimbursementType.others:
        return ReimbursementLabels.reimbursementTypeOthers;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case ReimbursementType.exam:
        return 'exames';
      case ReimbursementType.consultation:
        return 'consultas';
      case ReimbursementType.surgery:
        return 'cirurgias';
      case ReimbursementType.others:
        return 'outros';
      default:
        return null;
    }
  }
}

ReimbursementType? reimbursementTypeFromJson(String? reimbursementType) {
  switch (reimbursementType) {
    case 'exames':
      return ReimbursementType.exam;
    case 'consultas':
      return ReimbursementType.consultation;
    case 'cirurgias':
      return ReimbursementType.surgery;
    case 'outros':
      return ReimbursementType.others;
    default:
      return null;
  }
}
