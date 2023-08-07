import 'package:flutter_triple/flutter_triple.dart';

class AuthStore extends NotifierStore<Exception, String> {
  AuthStore() : super('auth');

  set authPath(String value) => update(value);
  String get authPath => state;
}
