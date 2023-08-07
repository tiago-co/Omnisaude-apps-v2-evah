import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_model.dart';
import 'package:omni_core/src/app/modules/extra_data/extra_data_repository.dart';
import 'package:omni_general/omni_general.dart' show QueryParamsModel;

class ExtraDataHistoricStore
    extends NotifierStore<DioError, DynamicFormResultsModel> {
  final ExtraDataRepository _repository = Modular.get();
  final QueryParamsModel params = QueryParamsModel();

  ExtraDataHistoricStore() : super(DynamicFormResultsModel(results: []));

  Future<void> getAnsweredExtraData(QueryParamsModel params) async {
    setLoading(true);
    await _repository.getAnsweredExtraData(params).then((dynamicForms) {
      update(dynamicForms);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<DynamicFormModel?> getAnsweredExtraDataById(String id) async {
    return _repository.getAnsweredExtraDataById(id);
  }
}
