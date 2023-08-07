import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_mediktor/omni_mediktor.dart';
import 'package:omni_mediktor/src/core/enums/mediktor_urgency_enum.dart';
import 'package:omni_mediktor/src/core/models/diagnosis_result_model.dart';
import 'package:omni_mediktor/src/core/models/recomendation_model.dart';

class MediktorRecomendationStore
    extends NotifierStore<DioError, RecomendationModel> with Disposable {
  MediktorRecomendationStore() : super(RecomendationModel());

  final MediktorRepository _repository = Modular.get();

  Future<void> sendHighUrgencyDiagnosis() async {
    setLoading(true);

    final Map<String, dynamic> diagnosisResult = DiagnosisResultModel(
      urgency: state.diagnosis!.urgency!.toJson,
      reason: state.diagnosis!.reason,
      sessionConclusions:
          state.diagnosis!.sessionConclusions?.summarySessionConclusionList,
    ).toJson();

    await _repository.sendHighUrgencyDiagnosis(diagnosisResult).then((value) {
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
