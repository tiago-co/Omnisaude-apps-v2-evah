import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/new_exam_model.dart';
import 'package:omni_core/src/app/modules/exams/exams_repository.dart';
import 'package:omni_general/omni_general.dart' show QueryParamsModel;

class ExamsStore extends NotifierStore<DioError, ExamsResultsModel>
    with Disposable {
  final ExamsRepository _repository = Modular.get();
  final QueryParamsModel params = QueryParamsModel(limit: '10');

  ExamsStore() : super(ExamsResultsModel(results: []));

  Timer? _debounce;

  Future<void> getExams(QueryParamsModel params) async {
    setLoading(true);
    await _repository.getExams(params).then(
      (exams) {
        update(exams!);
        setLoading(false);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        setError(onError);
      },
    );
  }

  Future<void> getExamsByName(
    String? caregiver,
    QueryParamsModel params,
  ) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 250),
      () async {
        params.name = caregiver ?? '';
        await getExams(params);
      },
    );
  }

  @override
  void dispose() {
    _repository.dispose();
    _debounce?.cancel();
  }
}
