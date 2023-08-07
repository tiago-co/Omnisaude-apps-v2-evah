import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/models/specialty_model.dart';
import 'package:omni_scheduling/src/core/repositories/scheduling_repository.dart';

import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_historic_store.dart';

// ignore: must_be_immutable
class SchedulingSpecialtyFilterStore
    extends NotifierStore<DioError, SpecialtyModel> with Disposable {
  final SchedulingHistoricStore historicStore = Modular.get();
  final SchedulingRepository _repository = Modular.get();

  SchedulingSpecialtyFilterStore() : super(SpecialtyModel());

  SpecialtyResults specialties = SpecialtyResults(results: []);
  Timer? _debounce;

  Future<void> getSpecialtiesParams(String? specialty) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      setLoading(true);
      await _repository.getSpecialtiesParams(specialty).then((results) {
        specialties = results!;
        setLoading(false);
      }).catchError((onError) {
        setLoading(false);
        setError(onError);
      });
    });
  }

  Future<void> onChangeSpecialty(SpecialtyModel specialty) async {
    update(specialty);
    historicStore.params.specialty = specialty.id;
    historicStore.getSchedules(historicStore.params);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _repository.dispose();
  }
}
