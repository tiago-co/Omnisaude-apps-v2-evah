import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_plan/src/core/models/direct_debit_model.dart';
import 'package:omni_plan/src/core/models/direct_debit_params_model.dart';
import 'package:omni_plan/src/modules/direct_debit/direct_debit_repository.dart';

// ignore: must_be_immutable
class DirectDebitStore extends NotifierStore<DioError, DirectDebitModel>
    with Disposable {
  DirectDebitStore() : super(DirectDebitModel());

  final DirectDebitRepository _repository = Modular.get();
  DirectDebitParamsModel params = DirectDebitParamsModel();

  @override
  void dispose() {
    _repository.dispose();
  }

  Future<void> getDirectDebitSolicitation() async {
    setLoading(true);
    await _repository.getDirectDebitSolicitation().then((value) {
      update(value);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> createRegisterDirectDebito(
    DirectDebitParamsModel params,
  ) async {
    setLoading(true);
    await _repository.createRegisterDirectDebito(params).then((value) {
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }
}
