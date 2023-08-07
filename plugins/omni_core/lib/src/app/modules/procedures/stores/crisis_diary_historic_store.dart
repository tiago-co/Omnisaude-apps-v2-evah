import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/dynamic_form_model.dart';
import 'package:omni_core/src/app/modules/procedures/crisis_diary_repository.dart';
import 'package:omni_general/omni_general.dart';

// ignore: must_be_immutable
class CrisisDiaryHistoricStore
    extends NotifierStore<DioError, DynamicFormResultsModel> with Disposable {
  final CrisisDiaryRepository _repository = Modular.get();
  final QueryParamsModel params = QueryParamsModel(limit: '10');

  CrisisDiaryHistoricStore() : super(DynamicFormResultsModel(results: []));

  Timer? _debounce;

  Future<void> getAnsweredCrisisDiaries(QueryParamsModel params) async {
    setLoading(true);
    await _repository.getAnsweredCrisisDiaries(params).then((crisisDiaries) {
      update(crisisDiaries);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<DynamicFormModel> getAnsweredCrisisDiaryById(String id) async {
    return _repository.getAnsweredCrisisDiaryById(id);
  }

  Future<void> getAnsweredCrisisDiariesParams(String? form) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      params.name = form;
      await getAnsweredCrisisDiaries(params);
    });
  }

  @override
  void dispose() {
    _repository.dispose();
    _debounce?.cancel();
  }
}
