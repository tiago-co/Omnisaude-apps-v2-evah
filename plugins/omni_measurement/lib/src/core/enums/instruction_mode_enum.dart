enum InstructionModeEnum { automatic, camera, manual }

extension InstructionModeEnumExtension on InstructionModeEnum {
  String? get helpOne {
    switch (this) {
      case InstructionModeEnum.automatic:
        return 'Ative a conexão Bluetooth no seu celular.';
      case InstructionModeEnum.camera:
        return 'Procure um ambiente bem iluminado.';
      case InstructionModeEnum.manual:
        return 'Ligue seu';
      default:
        return toString();
    }
  }

  String? get helpTwo {
    switch (this) {
      case InstructionModeEnum.automatic:
        return 'Ligue seu';
      case InstructionModeEnum.camera:
        return 'Enquadre a medição e faça uma foto.';
      case InstructionModeEnum.manual:
        return 'Informe o resultado da medição.';
      default:
        return toString();
    }
  }

  String? get helpThree {
    switch (this) {
      case InstructionModeEnum.automatic:
        return 'Toque em "Continuar"';
      case InstructionModeEnum.camera:
        return 'Toque em "Continuar"';
      case InstructionModeEnum.manual:
        return 'Toque em "Continuar"';

      default:
        return toString();
    }
  }

  String get assetBaselOne {
    switch (this) {
      case InstructionModeEnum.automatic:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_bluetooth.svg';
      case InstructionModeEnum.camera:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_lampada.svg';
      case InstructionModeEnum.manual:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_power.svg';
      default:
        return 'assets/icons/mode_measurement/measurement_manual.svg';
    }
  }

  String get assetBaseTwo {
    switch (this) {
      case InstructionModeEnum.automatic:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_power.svg';
      case InstructionModeEnum.camera:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_enquadramento.svg';
      case InstructionModeEnum.manual:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_teclado.svg';
      default:
        return 'assets/instructions_mode/manual/instruction_manual_base.svg';
    }
  }

  String get assetBaselThree {
    switch (this) {
      case InstructionModeEnum.automatic:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_toque.svg';
      case InstructionModeEnum.camera:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_toque.svg';
      case InstructionModeEnum.manual:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_toque.svg';
      default:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_white_toque.svg';
    }
  }

  String get assetColorlOne {
    switch (this) {
      case InstructionModeEnum.automatic:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_one_color.svg';
      case InstructionModeEnum.camera:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_one_color.svg';
      case InstructionModeEnum.manual:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_one_color.svg';
      default:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_one_color.svg';
    }
  }

  String get assetColorlTwo {
    switch (this) {
      case InstructionModeEnum.automatic:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_two_color.svg';
      case InstructionModeEnum.camera:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_two_color.svg';
      case InstructionModeEnum.manual:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_two_color.svg';
      default:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_two_color.svg';
    }
  }

  String get assetColorlThree {
    switch (this) {
      case InstructionModeEnum.automatic:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_three_color.svg';
      case InstructionModeEnum.camera:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_three_color.svg';
      case InstructionModeEnum.manual:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_three_color.svg';
      default:
        return 'assets/instructions_mode/icon_tutorial/icon_tutorial_base_three_color.svg';
    }
  }
}
