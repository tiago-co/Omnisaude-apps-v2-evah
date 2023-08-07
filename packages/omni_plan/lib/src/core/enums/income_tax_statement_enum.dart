import 'package:income_tax_statement_labels/labels.dart';

enum IncomeTaxStatementType { reimbursement, referencedNetwork }

extension IncomeTaxStatementTypeExtension on IncomeTaxStatementType {
  String get label {
    switch (this) {
      case IncomeTaxStatementType.reimbursement:
        return IncomeTaxStatementLabels.incomeTaxStatementTypeReimbursement;
      case IncomeTaxStatementType.referencedNetwork:
        return IncomeTaxStatementLabels.incomeTaxStatementTypeReferencedNetwork;
    }
  }

  String? get toJson {
    switch (this) {
      case IncomeTaxStatementType.reimbursement:
        return 'reimbursement';
      case IncomeTaxStatementType.referencedNetwork:
        return 'referencedNetwork';
    }
  }
}
