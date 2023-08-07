import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/core/models/reset_password_model.dart';
import 'package:omni_auth/src/modules/reset_password/reset_password_repository.dart';

class ResetPasswordStore extends NotifierStore<Exception, ResetPasswordModel> {
  final ResetPasswordRepository _repository = Modular.get();
  ResetPasswordStore() : super(ResetPasswordModel());

  void updateForm(ResetPasswordModel form) {
    update(ResetPasswordModel.fromJson(form.toJson()));
  }

  bool isDisabled({required int page}) {
    try {
      switch (page) {
        case 0:
          final bool isDisable = (state.cpf == null || state.cpf!.isEmpty) ||
              (state.email == null || state.email!.isEmpty);
          return isDisable;
        case 1:
          final bool isDisable =
              state.token!.length != 8 || state.token!.isEmpty;
          return isDisable;
        case 2:
          final bool isDisable =
              state.password == null || state.password!.isEmpty;
          return isDisable;
        default:
          return false;
      }
    } catch (e) {
      log('isDisabled: $e');
      return false;
    }
  }

  Future<void> getAccessToken(ResetPasswordModel model) async {
    setLoading(true);

    model.cpf = model.cpf!.replaceAll('.', '');
    model.cpf = model.cpf!.replaceAll('-', '');
    update(model);

    try {
      await _repository.getAccessToken(model);
    } catch (e) {
      setLoading(false);

      rethrow;
    }
    setLoading(false);
  }

  Future<void> validateAccessToken(ResetPasswordModel model) async {
    setLoading(true);
    try {
      await _repository.validateAccessToken(model).then((value) {
        state.id = value;
        update(state);
        setLoading(false);
      });
    } catch (e) {
      setLoading(false);
      rethrow;
    }
  }

  Future<void> resetPassword(ResetPasswordModel model) async {
    setLoading(true);

    try {
      await _repository.resetPassword(model).catchError((onError) {
        setLoading(false);
        throw onError;
      });
    } catch (e) {
      setLoading(false);
      rethrow;
    }
  }
}
