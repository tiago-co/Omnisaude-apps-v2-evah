import 'package:reimbursement_labels/labels.dart';

enum ReimbursementStatus { approved, denied, partial, analysis }

extension ReimbursementStatusExtension on ReimbursementStatus {
  String get label {
    switch (this) {
      case ReimbursementStatus.approved:
        return ReimbursementLabels.reimbursementStatusApproved;
      case ReimbursementStatus.denied:
        return ReimbursementLabels.reimbursementStatusDenied;
      case ReimbursementStatus.partial:
        return ReimbursementLabels.reimbursementStatusPartial;
      case ReimbursementStatus.analysis:
        return ReimbursementLabels.reimbursementStatusAnalysis;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case ReimbursementStatus.approved:
        return 'aprovado';
      case ReimbursementStatus.denied:
        return 'negado';
      case ReimbursementStatus.partial:
        return 'parcial';
      case ReimbursementStatus.analysis:
        return 'analise';
      default:
        return null;
    }
  }
}

ReimbursementStatus? reimbursementStatusFromJson(String? reimbursementStatus) {
  switch (reimbursementStatus) {
    case 'aprovado':
      return ReimbursementStatus.approved;
    case 'negado':
      return ReimbursementStatus.denied;
    case 'parcial':
      return ReimbursementStatus.partial;
    case 'analise':
      return ReimbursementStatus.analysis;
    default:
      return null;
  }
}
