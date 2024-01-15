import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ResetPasswordFieldStore extends NotifierStore<Exception, String> {
  ResetPasswordFieldStore() : super('');

  bool get isDisabled {
    return state.isEmpty || !state.contains('@');
  }
}
