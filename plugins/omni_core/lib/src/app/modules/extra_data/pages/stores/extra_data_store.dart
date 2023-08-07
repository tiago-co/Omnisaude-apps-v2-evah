import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/answer_dynamic_form_model.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_model.dart';
import 'package:omni_core/src/app/modules/extra_data/extra_data_repository.dart';
import 'package:omni_core/src/app/modules/extra_data/pages/stores/extra_data_historic_store.dart';
import 'package:omni_general/omni_general.dart';

class ExtraDataStore extends NotifierStore<DioError, DynamicFormResultsModel> {
  final ExtraDataRepository _repository = Modular.get();
  final QueryParamsModel params = QueryParamsModel();
  final ExtraDataHistoricStore historicStore = Modular.get();

  ExtraDataStore() : super(DynamicFormResultsModel(results: []));

  Future<void> getExtraData(QueryParamsModel params) async {
    setLoading(true);
    await _repository.getExtraData(params).then((dynamicForms) {
      update(dynamicForms);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<DynamicFormModel?> getExtraDataById(String id) async {
    return _repository.getExtraDataById(id);
  }

  Future<DynamicFormModel> answerExtraData(AnswerDynamicFormModel data) async {
    return _repository.answerExtraData(data);
  }
}
