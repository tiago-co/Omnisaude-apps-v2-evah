import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/procedure_model.dart';
import 'package:omni_core/src/app/modules/procedures/procedures_repository.dart';
import 'package:omni_core/src/app/modules/procedures/stores/procedures_store.dart';

// ignore: must_be_immutable
class ProcedureDetailsStore extends NotifierStore<DioError, ProcedureModel>
    with Disposable {
  final ProceduresRepository _repository = Modular.get();
  final ProceduresStore proceduresStore = Modular.get();

  String refuseReason = '';

  ProcedureDetailsStore() : super(ProcedureModel());

  Future<void> getProcedureById(String id) async {
    setLoading(true);
    await _repository.getProcedureById(id).then((procedure) {
      update(procedure);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> updateProcedure(String id, Map<String, String> data) async {
    setLoading(true);
    await _repository.updateProcedure(id, data).then((procedure) {
      final List<ProcedureModel> procedures = proceduresStore.state.results.map(
        (obj) {
          if (obj.id == procedure.id) return procedure;
          return obj;
        },
      ).toList();
      proceduresStore.state.results.clear();
      proceduresStore.state.results.addAll(procedures);
      proceduresStore.update(
        ProcedureResultsModel.fromJson(
          proceduresStore.state.toJson(),
        ),
      );
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
      throw onError;
    });
  }

  void onChangeTextFieldValue(String? input) {
    setLoading(true);
    refuseReason = input ?? '';
    setLoading(false);
  }

  bool get isDisabled => refuseReason.isEmpty;

  @override
  void dispose() {
    _repository.dispose();
  }
}
