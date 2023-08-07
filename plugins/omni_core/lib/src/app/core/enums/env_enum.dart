import 'package:drawer_labels/labels.dart';

enum EnvType {
  prod,
  homol,
  demo,
}

extension EnvTypeExtension on EnvType {
  String get label {
    switch (this) {
      case EnvType.prod:
        return DrawerLabels.envTypeProd;
      case EnvType.homol:
        return DrawerLabels.envTypeHomol;
      case EnvType.demo:
        return DrawerLabels.envTypeDemo;
      default:
        return toString();
    }
  }
}
