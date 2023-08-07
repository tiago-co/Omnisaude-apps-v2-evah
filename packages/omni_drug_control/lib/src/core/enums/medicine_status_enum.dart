import 'package:flutter/material.dart';
import 'package:omni_drug_control_labels/labels.dart';

enum MedicineStatusTypeEnum { consumed, notConsumed, pendent, late }

extension MedicineStatusTypeEnumExtension on MedicineStatusTypeEnum {
  String get label {
    switch (this) {
      case MedicineStatusTypeEnum.consumed:
        return DrugControlLabels.medicineStatusTypeConsumed;
      case MedicineStatusTypeEnum.notConsumed:
        return DrugControlLabels.medicineStatusTypeNotConsumed;
      case MedicineStatusTypeEnum.pendent:
        return DrugControlLabels.medicineStatusTypePendent;
      case MedicineStatusTypeEnum.late:
        return DrugControlLabels.medicineStatusTypeLate;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case MedicineStatusTypeEnum.consumed:
        return 'c';
      case MedicineStatusTypeEnum.notConsumed:
        return 'x';
      case MedicineStatusTypeEnum.pendent:
        return 'p';
      case MedicineStatusTypeEnum.late:
        return 'a';
      default:
        return null;
    }
  }

  Widget? get getMedicineWidget {
    switch (this) {
      case MedicineStatusTypeEnum.consumed:
        return Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            // border: Border.all(
            //   color: Colors.green,
            // ),
            color: Colors.green,
          ),
          width: 20,
          height: 20,
          child: const Center(
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 15,
            ),
          ),
        );
      case MedicineStatusTypeEnum.notConsumed:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: Colors.red.withOpacity(0.75),
            ),
            color: Colors.white,
          ),
          width: 20,
          height: 20,
          child: Center(
            child: Icon(
              Icons.close,
              color: Colors.red.withOpacity(0.75),
              size: 15,
            ),
          ),
        );
      case MedicineStatusTypeEnum.pendent:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: Colors.amber,
            ),
            color: Colors.white,
          ),
          width: 20,
          height: 20,
        );
      case MedicineStatusTypeEnum.late:
        return Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 2,
              color: Colors.amber,
            ),
            color: Colors.white,
          ),
          width: 20,
          height: 20,
          child: const Center(
            child: Text(
              '!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      default:
        return null;
    }
  }

  Color? get getColorStatusMedicine {
    switch (this) {
      case MedicineStatusTypeEnum.consumed:
        return Colors.green;
      case MedicineStatusTypeEnum.notConsumed:
        return Colors.red.withOpacity(0.75);
      case MedicineStatusTypeEnum.pendent:
        return Colors.amber;
      case MedicineStatusTypeEnum.late:
        return Colors.amber;
      default:
        return null;
    }
  }
}

MedicineStatusTypeEnum? medicineStatusTypeEnumFromJson(String? type) {
  switch (type) {
    case 'c':
      return MedicineStatusTypeEnum.consumed;
    case 'x':
      return MedicineStatusTypeEnum.notConsumed;
    case 'p':
      return MedicineStatusTypeEnum.pendent;
    case 'a':
      return MedicineStatusTypeEnum.late;
    default:
      return null;
  }
}
