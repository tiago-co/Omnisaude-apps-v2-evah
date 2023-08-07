import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/app_stores/program_store.dart';
import 'package:omni_core/src/app/core/models/procedure_model.dart';
import 'package:omni_core/src/app/core/models/procedure_params_model.dart';
import 'package:omni_core/src/app/modules/procedures/procedures_repository.dart';

// ignore: must_be_immutable
class ProceduresStore extends NotifierStore<DioError, ProcedureResultsModel>
    with Disposable {
  final ProceduresRepository _repository = Modular.get();
  final ProgramStore programStore = Modular.get();

  ProceduresStore() : super(ProcedureResultsModel(results: []));

  Timer? _debounce;
  final ProcedureParamsModel params = ProcedureParamsModel();

  Future<void> getProcedures([ProcedureParamsModel? params]) async {
    setLoading(true);
    await _repository.getProcedures(params).then((procedures) {
      update(procedures);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> getProceduresParams(
    String? procedure,
    ProcedureParamsModel params,
  ) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      params.name = procedure ?? '';
      await getProcedures(params);
    });
  }

  @override
  void dispose() {
    _repository.dispose();
    _debounce?.cancel();
  }
}
