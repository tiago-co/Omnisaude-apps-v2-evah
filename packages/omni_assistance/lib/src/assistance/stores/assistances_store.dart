import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_assistance/src/assistance/assistance_repository.dart';
import 'package:omni_assistance/src/core/models/assistance_model.dart';
import 'package:omni_assistance/src/core/models/assistance_query_params_model.dart';

// ignore: must_be_immutable
class AssistancesStore extends NotifierStore<DioError, AssistanceResultsModel> {
  AssistancesStore() : super(AssistanceResultsModel(results: []));

  final AssistanceRepository _repository = Modular.get();
  final AssistanceQueryParamsModel params = AssistanceQueryParamsModel();

  Timer? _debounce;

  Future<void> getAssistancesList(AssistanceQueryParamsModel params) async {
    setLoading(true);
    await _repository.getAssistanceList(params).then((assistanceList) {
      update(assistanceList);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> getAssistancesBySubject(
      String? subject, AssistanceQueryParamsModel params) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      params.subject = subject ?? '';
      await getAssistancesList(params);
    });
  }
}
