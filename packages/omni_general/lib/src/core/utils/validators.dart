class Validators {
  static String? emptyField(String? input) {
    if (input == null) {
      return 'Este campo não pode ser vazio';
    } else if (input.isEmpty) {
      return 'Este campo não pode ser vazio';
    } else {
      return null;
    }
  }

  static String? invalidPhoneNumber(String? input) {
    if (input!.length < 9) {
      return 'Telefone deve ter pelo menos nove digitos';
    } else {
      return null;
    }
  }
}
