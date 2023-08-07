import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Masks {
  MaskTextInputFormatter get cpf {
    return MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {'#': RegExp(r'[0-9]')},
    );
  }

  MaskTextInputFormatter get bankAgency {
    return MaskTextInputFormatter(
      mask: '####',
      filter: {'#': RegExp(r'[0-9]')},
    );
  }

  MaskTextInputFormatter get bankAcount {
    return MaskTextInputFormatter(
      mask: '#######',
      filter: {'#': RegExp(r'[0-9]')},
    );
  }

  MaskTextInputFormatter get bankAcountDig {
    return MaskTextInputFormatter(
      mask: '#',
      filter: {'#': RegExp(r'[0-9]')},
    );
  }

  MaskTextInputFormatter get phone {
    return MaskTextInputFormatter(
      mask: '(##) # ####-####',
      filter: {'#': RegExp(r'[0-9]')},
    );
  }

  MaskTextInputFormatter get date {
    return MaskTextInputFormatter(
      mask: '##/##/####',
      filter: {'#': RegExp(r'[0-9]')},
    );
  }

  MaskTextInputFormatter get height {
    return MaskTextInputFormatter(
      mask: '#.##',
      filter: {'#': RegExp(r'[0-9]')},
    );
  }

  static MaskTextInputFormatter generateMask(String mask) {
    return MaskTextInputFormatter(
      mask: mask,
      filter: {'#': RegExp(r'[0-9]')},
    );
  }
}
