import 'package:flutter/material.dart';
import 'package:income_tax_statement_labels/labels.dart';

enum RequisitionStatus {
  approved,
  denied,
  partial,
  audit,
  statusDefault,
  all,
}

extension RequisitionStatusExtension on RequisitionStatus {
  String get label {
    switch (this) {
      case RequisitionStatus.approved:
        return IncomeTaxStatementLabels.requisistionStatusApproved;
      case RequisitionStatus.denied:
        return IncomeTaxStatementLabels.requisistionStatusDenied;
      case RequisitionStatus.partial:
        return IncomeTaxStatementLabels.requisistionStatusPartial;
      case RequisitionStatus.audit:
        return IncomeTaxStatementLabels.requisistionStatusAudit;
      case RequisitionStatus.all:
        return IncomeTaxStatementLabels.requisistionStatusAll;
      case RequisitionStatus.statusDefault:
        return IncomeTaxStatementLabels.requisistionStatusStatusDefault;
    }
  }

  String? get toJson {
    switch (this) {
      case RequisitionStatus.approved:
        return 'Aprovada';
      case RequisitionStatus.denied:
        return 'Reprovada';
      case RequisitionStatus.partial:
        return 'Parcialmente aprovada';
      case RequisitionStatus.audit:
        return 'Auditoria';
      case RequisitionStatus.all:
        return '';
      case RequisitionStatus.statusDefault:
        return toString();
    }
  }

  Color? get color {
    switch (this) {
      case RequisitionStatus.approved:
        return Colors.green.withOpacity(0.8);
      case RequisitionStatus.denied:
        return Colors.grey;
      case RequisitionStatus.partial:
        return Colors.amber.withOpacity(0.8);
      case RequisitionStatus.audit:
        return Colors.blue.withOpacity(0.8);
      default:
        return Colors.grey;
    }
  }
}

RequisitionStatus? requisitionStatusFromJson(String? requisitionStatus) {
  switch (requisitionStatus) {
    case 'Aprovada':
      return RequisitionStatus.approved;
    case 'Reprovada':
      return RequisitionStatus.denied;
    case 'Parcialmente aprovada':
      return RequisitionStatus.partial;
    case 'Auditoria':
      return RequisitionStatus.audit;
    case 'Todos':
      return RequisitionStatus.all;
    default:
      return RequisitionStatus.statusDefault;
  }
}
