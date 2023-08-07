import 'package:omni_measurement_labels/labels.dart';

enum MeasurementMode { automatic, camera, manual }

extension MeasurementModeExtension on MeasurementMode {
  String? get label {
    switch (this) {
      case MeasurementMode.automatic:
        return MeasurementLabels.measurementModeAutomatic;
      case MeasurementMode.camera:
        return MeasurementLabels.measurementModeCamera;
      case MeasurementMode.manual:
        return MeasurementLabels.measurementModeManual;
      default:
        return toString();
    }
  }

  String? get modeText {
    switch (this) {
      case MeasurementMode.automatic:
        return 'Automático via Bluetooth';
      case MeasurementMode.camera:
        return 'Enviar foto da medição';
      case MeasurementMode.manual:
        return 'Inserir medição manual';
      default:
        return toString();
    }
  }

  String? get helpOne {
    switch (this) {
      case MeasurementMode.automatic:
        return 'Ative a conexão Bluetooth no seu celular.';
      case MeasurementMode.camera:
        return 'Procure um ambiente bem iluminado.';
      case MeasurementMode.manual:
        return 'Ligue seu';
      default:
        return toString();
    }
  }

  String? get helpTwo {
    switch (this) {
      case MeasurementMode.automatic:
        return 'Ligue seu';
      case MeasurementMode.camera:
        return 'Enquadre a medição e faça uma foto.';
      case MeasurementMode.manual:
        return 'Informe o resultado da medição.';
      default:
        return toString();
    }
  }

  String? get helpThree {
    switch (this) {
      case MeasurementMode.automatic:
        return 'Toque em "Continuar"';
      case MeasurementMode.camera:
        return 'Toque em "Continuar"';
      case MeasurementMode.manual:
        return 'Toque em "Continuar"';

      default:
        return toString();
    }
  }

  String? get toJson {
    switch (this) {
      case MeasurementMode.automatic:
        return 'automatico';
      case MeasurementMode.camera:
        return 'camera';
      case MeasurementMode.manual:
        return 'manual';
      default:
        return null;
    }
  }

  String get asset {
    switch (this) {
      case MeasurementMode.automatic:
        return 'assets/icons/mode_measurement/measurement_automatic.svg';
      case MeasurementMode.camera:
        return 'assets/icons/mode_measurement/measurement_camera.svg';
      case MeasurementMode.manual:
        return 'assets/icons/mode_measurement/measurement_manual.svg';
      default:
        return 'assets/icons/mode_measurement/measurement_manual.svg';
    }
  }

  String get assetInstructionBase {
    switch (this) {
      case MeasurementMode.automatic:
        return 'assets/instructions_mode/automatic/instruction_automatic_base.svg';
      case MeasurementMode.camera:
        return 'assets/instructions_mode/camera/instruction_camera_base.svg';
      case MeasurementMode.manual:
        return 'assets/instructions_mode/manual/instruction_manual_base.svg';
      default:
        return 'assets/instructions_mode/manual/instruction_manual_base.svg';
    }
  }

  String get assetInstructionColor {
    switch (this) {
      case MeasurementMode.automatic:
        return 'assets/instructions_mode/automatic/instruction_automatic_color.svg';
      case MeasurementMode.camera:
        return 'assets/instructions_mode/camera/instruction_camera_color.svg';
      case MeasurementMode.manual:
        return 'assets/instructions_mode/manual/instruction_manual_color.svg';
      default:
        return 'assets/instructions_mode/manual/instruction_manual_color.svg';
    }
  }

  String get assetBaselOne {
    switch (this) {
      case MeasurementMode.automatic:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_bluetooth.svg';
      case MeasurementMode.camera:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_lampada.svg';
      case MeasurementMode.manual:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_power.svg';
      default:
        return 'assets/icons/mode_measurement/measurement_manual.svg';
    }
  }

  String get assetBaseTwo {
    switch (this) {
      case MeasurementMode.automatic:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_power.svg';
      case MeasurementMode.camera:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_enquadramento.svg';
      case MeasurementMode.manual:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_teclado.svg';
      default:
        return 'assets/instructions_mode/manual/instruction_manual_base.svg';
    }
  }

  String get assetBaseThree {
    switch (this) {
      case MeasurementMode.automatic:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_toque.svg';
      case MeasurementMode.camera:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_toque.svg';
      case MeasurementMode.manual:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_toque.svg';
      default:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_toque.svg';
    }
  }

  String get assetColorlOne {
    switch (this) {
      case MeasurementMode.automatic:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_one_color.svg';
      case MeasurementMode.camera:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_one_color.svg';
      case MeasurementMode.manual:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_one_color.svg';
      default:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_one_color.svg';
    }
  }

  String get assetColorlTwo {
    switch (this) {
      case MeasurementMode.automatic:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_two_color.svg';
      case MeasurementMode.camera:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_two_color.svg';
      case MeasurementMode.manual:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_two_color.svg';
      default:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_two_color.svg';
    }
  }

  String get assetColorlThree {
    switch (this) {
      case MeasurementMode.automatic:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_three_color.svg';
      case MeasurementMode.camera:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_three_color.svg';
      case MeasurementMode.manual:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_three_color.svg';
      default:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_three_color.svg';
    }
  }
}

MeasurementMode? measurementModeFromJson(String? type) {
  switch (type) {
    case 'automatico':
      return MeasurementMode.automatic;
    case 'camera':
      return MeasurementMode.camera;
    case 'manual':
      return MeasurementMode.manual;
    default:
      return null;
  }
}
