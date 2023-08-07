import 'package:flutter/material.dart';
import 'package:income_tax_statement_labels/labels.dart';

enum ItemStatusRequisition {
  releasedUser,
  releasedSystem,
  deniedUser,
  underAnalysis,
  deniedSystem,
  canceled,
  statusDefault,
}

extension ItemStatusRequisitionExtension on ItemStatusRequisition {
  String get label {
    switch (this) {
      case ItemStatusRequisition.releasedSystem:
        return IncomeTaxStatementLabels.itemStatusRequisitionReleasedSystem;
      case ItemStatusRequisition.releasedUser:
        return IncomeTaxStatementLabels.itemStatusRequisitionReleasedUser;
      case ItemStatusRequisition.deniedUser:
        return IncomeTaxStatementLabels.itemStatusRequisitionDeniedUser;
      case ItemStatusRequisition.underAnalysis:
        return IncomeTaxStatementLabels.itemStatusRequisitionUnderAnalysis;
      case ItemStatusRequisition.canceled:
        return IncomeTaxStatementLabels.itemStatusRequisitionCanceled;
      case ItemStatusRequisition.deniedSystem:
        return IncomeTaxStatementLabels.itemStatusRequisitionDeniedSystem;
      default:
        return IncomeTaxStatementLabels.itemStatusRequisitionDeniedDefault;
    }
  }

  String? get toJson {
    switch (this) {
      case ItemStatusRequisition.releasedSystem:
        return 'Liberado pelo sistemas';
      case ItemStatusRequisition.releasedUser:
        return 'Liberado pelo usuário';
      case ItemStatusRequisition.deniedUser:
        return 'Negado pelo usuário';
      case ItemStatusRequisition.underAnalysis:
        return 'Em análise';
      case ItemStatusRequisition.canceled:
        return 'Cancelado';
      case ItemStatusRequisition.deniedSystem:
        return 'Negado pelo sistema';
      case ItemStatusRequisition.statusDefault:
        return toString();
    }
  }

  Color? get color {
    switch (this) {
      case ItemStatusRequisition.releasedUser:
        return Colors.green.withOpacity(0.8);
      case ItemStatusRequisition.releasedSystem:
        return Colors.green.withOpacity(0.8);
      case ItemStatusRequisition.deniedUser:
        return Colors.red.withOpacity(0.8);
      case ItemStatusRequisition.underAnalysis:
        return Colors.amber.withOpacity(0.8);
      case ItemStatusRequisition.canceled:
        return Colors.blue.withOpacity(0.8);
      case ItemStatusRequisition.deniedSystem:
        return Colors.red.withOpacity(0.8);
      default:
        return Colors.grey;
    }
  }
}

ItemStatusRequisition? itemStatusRequisitionFromJson(
  String? itemStatusRequisition,
) {
  switch (itemStatusRequisition) {
    case 'Liberado pelo sistema':
      return ItemStatusRequisition.releasedSystem;
    case 'Liberado pelo usuário':
      return ItemStatusRequisition.releasedUser;
    case 'Negado pelo usuário':
      return ItemStatusRequisition.deniedUser;
    case 'Em análise':
      return ItemStatusRequisition.underAnalysis;
    case 'Negado pelo sistema':
      return ItemStatusRequisition.deniedSystem;
    case 'Cancelado':
      return ItemStatusRequisition.canceled;
    default:
      return ItemStatusRequisition.statusDefault;
  }
}
