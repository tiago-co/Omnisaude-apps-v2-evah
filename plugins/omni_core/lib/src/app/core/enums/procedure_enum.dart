import 'package:flutter/material.dart';
import 'package:procedures_labels/labels.dart';

enum ProcedureStatus {
  pending,
  accomplished,
  unrealized,
  approved,
  disapproved,
}

enum ProcedureType {
  maintenance,
  surgery,
  exam,
  removeDevice,
}

extension ProcedureStatusExtension on ProcedureStatus {
  String get label {
    switch (this) {
      case ProcedureStatus.pending:
        return ProceduresLabels.procedureStatusPending;
      case ProcedureStatus.accomplished:
        return ProceduresLabels.procedureStatusAccomplished;
      case ProcedureStatus.unrealized:
        return ProceduresLabels.procedureStatusUnrealized;
      case ProcedureStatus.approved:
        return ProceduresLabels.procedureStatusApproved;
      case ProcedureStatus.disapproved:
        return ProceduresLabels.procedureStatusDisapproved;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case ProcedureStatus.pending:
        return 'pe';
      case ProcedureStatus.accomplished:
        return 'rd';
      case ProcedureStatus.unrealized:
        return 'nr';
      case ProcedureStatus.approved:
        return 'ap';
      case ProcedureStatus.disapproved:
        return 'rp';
      default:
        return null;
    }
  }

  Color? get color {
    switch (this) {
      case ProcedureStatus.pending:
        return Colors.yellow.shade600;
      case ProcedureStatus.accomplished:
        return Colors.blue.shade600;
      case ProcedureStatus.unrealized:
        return Colors.grey.shade300;
      case ProcedureStatus.approved:
        return Colors.green.shade700;
      case ProcedureStatus.disapproved:
        return Colors.red;
      default:
        return null;
    }
  }
}

extension ProcedureTypeExtension on ProcedureType {
  String get label {
    switch (this) {
      case ProcedureType.maintenance:
        return ProceduresLabels.procedureTypeMaintenance;
      case ProcedureType.surgery:
        return ProceduresLabels.procedureTypeSurgery;
      case ProcedureType.exam:
        return ProceduresLabels.procedureTypeExam;
      case ProcedureType.removeDevice:
        return ProceduresLabels.procedureTypeRemoveDevice;
      default:
        return ProceduresLabels.procedureTypeRemoveDefault;
    }
  }

  String? get toJson {
    switch (this) {
      case ProcedureType.maintenance:
        return 'm';
      case ProcedureType.surgery:
        return 'c';
      case ProcedureType.exam:
        return 'e';
      case ProcedureType.removeDevice:
        return 'r';
      default:
        return null;
    }
  }
}

ProcedureStatus? procedureStatusFromJson(String? status) {
  switch (status) {
    case 'pe':
      return ProcedureStatus.pending;
    case 'rd':
      return ProcedureStatus.accomplished;
    case 'nr':
      return ProcedureStatus.unrealized;
    case 'ap':
      return ProcedureStatus.approved;
    case 'rp':
      return ProcedureStatus.disapproved;
    default:
      return null;
  }
}

ProcedureType? procedureTypeFromJson(String? type) {
  switch (type) {
    case 'm':
      return ProcedureType.maintenance;
    case 'c':
      return ProcedureType.surgery;
    case 'e':
      return ProcedureType.exam;
    case 'r':
      return ProcedureType.removeDevice;
    default:
      return null;
  }
}
