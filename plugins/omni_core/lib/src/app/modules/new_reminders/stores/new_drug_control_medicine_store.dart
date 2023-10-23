import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/new_reminders/repository/new_drug_control_repository.dart';
import 'package:omni_drug_control/src/core/models/medicine_base_model.dart';

import 'package:omni_general/omni_general.dart' show KeyValueResultsModel, QueryParamsModel;

// ignore: must_be_immutable
class NewDrugControlMedicineStore extends NotifierStore<DioError, List> with Disposable {
  final NewDrugControlRepository _repository = Modular.get();
  final QueryParamsModel params = QueryParamsModel();

  NewDrugControlMedicineStore() : super([]);

  KeyValueResultsModel customMedicines = KeyValueResultsModel(
    results: [],
  );
  MedicineBaseResults generalMedicines = MedicineBaseResults(results: []);

  Timer? _debounce;

  Future<void> getMedicines(
    QueryParamsModel params,
    bool useCustomMedication,
  ) async {
    setLoading(true);

    if (useCustomMedication) {
      await _repository.getCustomMedicines(params).then((medicines) {
        customMedicines = medicines;
        setLoading(false);
      }).catchError((onError) {
        setLoading(false);
        setError(onError);
      });
    } else {
      await _repository.getMedicines(params).then((medicines) {
        generalMedicines = medicines;
        setLoading(false);
      }).catchError((onError) {
        setLoading(false);
        setError(onError);
      });
    }
  }

  Future<void> getMedicinesParams(
    String? input,
    bool useCustomMedication,
  ) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 250), () async {
      params.name = input;
      await getMedicines(params, useCustomMedication);
    });
  }

  @override
  void dispose() {
    _repository.dispose();
    _debounce?.cancel();
  }
}
