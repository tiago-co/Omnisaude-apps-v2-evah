import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';

enum LecuponErrorsType {
  permissionDenied,
  requestError,
}

extension LecuponErrorsTypeExtension on LecuponErrorsType {
  Function() get onTap {
    switch (this) {
      case LecuponErrorsType.permissionDenied:
        return () {
          Permissions.openSettings();
          Modular.to.pop();
        };
      case LecuponErrorsType.requestError:
        return () {
          Modular.to.pop();
        };
    }
  }

  String get buttonText {
    switch (this) {
      case LecuponErrorsType.permissionDenied:
        return 'Abrir configurações';
      case LecuponErrorsType.requestError:
        return 'Tentar novamente';
    }
  }
}
