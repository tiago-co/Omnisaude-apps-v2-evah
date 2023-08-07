import 'package:omni_measurement_labels/labels.dart';

enum AreYouFeeling {
  good,
  normal,
  bad,
}

extension AreYouFeelingExtension on AreYouFeeling {
  String get label {
    switch (this) {
      case AreYouFeeling.good:
        return MeasurementLabels.feelingTypeGood;
      case AreYouFeeling.normal:
        return MeasurementLabels.feelingTypeNormal;
      case AreYouFeeling.bad:
        return MeasurementLabels.feelingTypeBad;
      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case AreYouFeeling.good:
        return 'bom';
      case AreYouFeeling.bad:
        return 'mal';
      case AreYouFeeling.normal:
        return 'normal';
      default:
        return null;
    }
  }

  String get asset {
    switch (this) {
      case AreYouFeeling.good:
        return 'assets/icons/smile/smile_good.svg';
      case AreYouFeeling.bad:
        return 'assets/icons/smile/smile_bad.svg';
      case AreYouFeeling.normal:
        return 'assets/icons/smile/smile_normal.svg';
      default:
        return 'assets/icons/smile/smile_normal.svg';
    }
  }
}

AreYouFeeling? areYouFeelingFromJson(String? type) {
  switch (type) {
    case 'bom':
      return AreYouFeeling.good;
    case 'mal':
      return AreYouFeeling.bad;
    case 'normal':
      return AreYouFeeling.normal;
    default:
      return null;
  }
}
