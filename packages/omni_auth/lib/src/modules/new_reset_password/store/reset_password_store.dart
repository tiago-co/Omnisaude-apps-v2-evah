import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/core/models/reset_password_model.dart';
import 'package:omni_auth/src/modules/new_reset_password/new_reset_password_repository.dart';

class ResetPasswordStore extends NotifierStore<Exception, ResetPasswordModel> {
  final NewResetPasswordRepository _repository = Modular.get();
  ResetPasswordStore() : super(ResetPasswordModel());

  void updateForm(ResetPasswordModel form) {
    update(ResetPasswordModel.fromJson(form.toJson()));
  }

  Future<void> newResetPassword(ResetPasswordModel model) async {
    setLoading(true);

    try {
      await _repository.newResetPassword(model).catchError((onError) {
        setLoading(false);
        throw onError;
      });
      setLoading(false);
    } catch (e) {
      setLoading(false);
      rethrow;
    }
  }
}
