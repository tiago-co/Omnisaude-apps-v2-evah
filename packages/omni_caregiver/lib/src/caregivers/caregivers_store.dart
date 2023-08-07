import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_caregiver/src/caregivers_repository.dart';
import 'package:omni_caregiver/src/core/models/caregiver_model.dart';
import 'package:omni_general/omni_general.dart' show QueryParamsModel;

// ignore: must_be_immutable
class CaregiversStore extends NotifierStore<DioError, CaregiverResultsModel>
    with Disposable {
  final CaregiversRepository _repository = Modular.get();
  final QueryParamsModel params = QueryParamsModel();

  CaregiversStore() : super(CaregiverResultsModel(results: []));

  Timer? _debounce;

  Future<void> getCaregivers(QueryParamsModel params) async {
    setLoading(true);
    await _repository.getCaregivers(params).then((caregivers) {
      update(caregivers!);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> getCaregiversByName(
    String? caregiver,
    QueryParamsModel params,
  ) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      params.name = caregiver ?? '';
      await getCaregivers(params);
    });
  }

  @override
  void dispose() {
    _repository.dispose();
    _debounce?.cancel();
  }
}
