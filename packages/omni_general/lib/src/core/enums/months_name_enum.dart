import 'package:omni_general_labels/labels.dart';

enum MonthsNameEnum {
  january,
  february,
  march,
  april,
  may,
  june,
  july,
  august,
  september,
  october,
  november,
  december
}

extension MonthsNameEnumExtension on MonthsNameEnum {
  String? get label {
    switch (this) {
      case MonthsNameEnum.january:
        return GeneralLabels.mothsNameEnumJanuary;
      case MonthsNameEnum.february:
        return GeneralLabels.mothsNameEnumFebruary;
      case MonthsNameEnum.march:
        return GeneralLabels.mothsNameEnumMarch;
      case MonthsNameEnum.april:
        return GeneralLabels.mothsNameEnumApril;
      case MonthsNameEnum.may:
        return GeneralLabels.mothsNameEnumMay;
      case MonthsNameEnum.june:
        return GeneralLabels.mothsNameEnumJune;
      case MonthsNameEnum.july:
        return GeneralLabels.mothsNameEnumJuly;
      case MonthsNameEnum.august:
        return GeneralLabels.mothsNameEnumAugust;
      case MonthsNameEnum.september:
        return GeneralLabels.mothsNameEnumSeptember;
      case MonthsNameEnum.october:
        return GeneralLabels.mothsNameEnumOctober;
      case MonthsNameEnum.november:
        return GeneralLabels.mothsNameEnumNovember;
      case MonthsNameEnum.december:
        return GeneralLabels.mothsNameEnumDecember;
    }
  }

  String? get toJson {
    switch (this) {
      case MonthsNameEnum.january:
        return 'janeiro';
      case MonthsNameEnum.february:
        return 'fevereiro';
      case MonthsNameEnum.march:
        return 'março';
      case MonthsNameEnum.april:
        return 'abril';
      case MonthsNameEnum.may:
        return 'maio';
      case MonthsNameEnum.june:
        return 'junho';
      case MonthsNameEnum.july:
        return 'julho';
      case MonthsNameEnum.august:
        return 'agosto';
      case MonthsNameEnum.september:
        return 'setembro';
      case MonthsNameEnum.october:
        return 'outubro';
      case MonthsNameEnum.november:
        return 'novembro';
      case MonthsNameEnum.december:
        return 'dezembro';
      default:
        return null;
    }
  }
}

MonthsNameEnum? monthsNameEnumFromDate(int? month) {
  switch (month) {
    case 01:
      return MonthsNameEnum.january;
    case 02:
      return MonthsNameEnum.february;
    case 03:
      return MonthsNameEnum.march;
    case 04:
      return MonthsNameEnum.april;
    case 05:
      return MonthsNameEnum.may;
    case 06:
      return MonthsNameEnum.june;
    case 07:
      return MonthsNameEnum.july;
    case 08:
      return MonthsNameEnum.august;
    case 09:
      return MonthsNameEnum.september;
    case 10:
      return MonthsNameEnum.october;
    case 11:
      return MonthsNameEnum.november;
    case 12:
      return MonthsNameEnum.december;
    default:
      return null;
  }
}
