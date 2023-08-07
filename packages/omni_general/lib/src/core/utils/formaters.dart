import 'package:intl/intl.dart';

import 'package:omni_general/src/core/enums/months_name_enum.dart';

class Formaters {
  static String formatNumber(double number) {
    final String locale = Intl.getCurrentLocale();
    return NumberFormat.decimalPattern('pt-br').format(number);
  }

  static String formatCPF(String cpf) {
    final String numeros = cpf.replaceAll(RegExp(r'[^0-9]'), '');
    if (numeros.length != 11) return cpf;
    return '${numeros.substring(0, 3)}.${numeros.substring(3, 6)}'
        '.${numeros.substring(6, 9)}-${numeros.substring(9)}';
  }

  static String formatPhone(String phone) {
    final String numeros = phone.replaceAll(RegExp(r'[^0-9]'), '');
    if (numeros.length != 11) return phone;
    if (numeros[0] == '0') {
      return '(${numeros.substring(0, 3)}) '
          '${numeros.substring(3, 7)}-${numeros.substring(7)}';
    }
    return '(${numeros.substring(0, 2)}) ${numeros.substring(2, 3)} '
        '${numeros.substring(3, 7)}-${numeros.substring(7)}';
  }

  static DateTime stringToDateTime(String date) {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').parse(date).toLocal();
  }

  static String stringMonthNameAndYear(String date) {
    final DateTime dateTime = stringToDate(date);

    return '${monthsNameEnumFromDate(dateTime.month)!.label}/${dateTime.year}';
  }

  static DateTime stringToDate(String date, {String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).parse(date).toLocal();
  }

  static String dateToStringDate(
    DateTime date, {
    String format = 'dd/MM/yyyy',
  }) {
    return DateFormat(format).format(date.toLocal());
  }

  static String dateToStringDateWithHifen(
    DateTime date, {
    String format = 'yyyy-MM-dd',
  }) {
    return DateFormat(format).format(date.toLocal());
  }

  static String dateToStringTime(DateTime date) {
    return DateFormat('Hm').format(date.toLocal());
  }

  static String dateToStringDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date.toLocal());
  }

  static String capitalize(String value, {String pattern = ' '}) {
    final List<String> splited = value.split(pattern);
    final List<String> capitalized = List.empty(growable: true);
    for (final item in splited) {
      capitalized.add(
        '${item[0].toUpperCase()}'
        '${item.substring(1).toLowerCase()}',
      );
    }
    return capitalized.join(' ');
  }

  //capitalize ignorando palavras como de, da, do, etc
  static String capitalizeIgnoringWords(String value, {String pattern = ' '}) {
    const String pronomes =
        'de|da|do|das|dos|em|a|e|o|ou|com|para|por|sem|sobre|';
    final List<String> splited = value.split(pattern);
    final List<String> capitalized = List.empty(growable: true);
    for (final item in splited) {
      if (pronomes.contains(item.toLowerCase())) {
        capitalized.add(item.toLowerCase());
      } else {
        capitalized.add(
          '${item[0].toUpperCase()}'
          '${item.substring(1).toLowerCase()}',
        );
      }
    }
    return capitalized.join(' ');
  }

  static String cardValid(DateTime date) {
    return DateFormat('MM/yyyy').format(date.toLocal());
  }

  static String dateToDDMMYYYY(String date) {
    final List<String> splited = date.split('-');
    return '${splited[2]}/${splited[1]}/${splited[0]}';
  }
}
