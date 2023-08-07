import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/models/professional_model.dart';
import 'package:omni_scheduling/src/core/repositories/scheduling_repository.dart';

import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_historic_store.dart';

// ignore: must_be_immutable
class SchedulingProfessionalFilterStore
    extends NotifierStore<DioError, ProfessionalModel> with Disposable {
  final SchedulingHistoricStore historicStore = Modular.get();
  final SchedulingRepository _repository = Modular.get();

  SchedulingProfessionalFilterStore() : super(ProfessionalModel());

  ProfessionalResults professionals = ProfessionalResults(results: []);
  Timer? _debounce;

  Future<void> getProfessionalParams(String? professional) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      setLoading(true);
      await _repository.getProfessionalParams(professional).then((results) {
        professionals = results!;
        setLoading(false);
      }).catchError((onError) {
        setLoading(false);
        setError(onError);
      });
    });
  }

  Future<void> onChangeProfessional(ProfessionalModel professional) async {
    update(professional);
    historicStore.params.professionalName = professional.name;
    historicStore.getSchedules(historicStore.params);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _repository.dispose();
  }
}
