import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/reset_password/reset_password_repository.dart';

class ResetPasswordFieldStore extends NotifierStore<Exception, String> {
  ResetPasswordFieldStore() : super('');
  final ResetPasswordRepository _repository = Modular.get();
  bool get isDisabled {
    return state.isEmpty || !state.contains('@');
  }

  Future<void> requestPasswordReset(String email) async {
    setLoading(true);
    final formattedEmail = email.toLowerCase().trim();
    try {
      await _repository.requestPasswordReset(formattedEmail).catchError((onError) {
        setLoading(false);
        throw onError;
      });
    } catch (e) {
      setLoading(false);
      rethrow;
    } finally {
      setLoading(false);
    }
  }
}
