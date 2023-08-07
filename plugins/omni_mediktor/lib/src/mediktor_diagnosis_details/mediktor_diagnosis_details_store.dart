import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_mediktor/src/core/models/mediktor_diagnosis_model.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/mediktor_diagnosis_store.dart';

import 'package:omni_mediktor/src/mediktor_repository.dart';

class MediktorDiagnosisDetailsStore
    extends NotifierStore<Exception, MediktorDiagnosisModel> with Disposable {
  final MediktorRepository _repository = Modular.get();

  final MediktorDiagnosisStore mediktorDiagnosisStore =
      MediktorDiagnosisStore();

  MediktorDiagnosisDetailsStore() : super(MediktorDiagnosisModel());

  Future<void> getDiagnosisDetails(String sessionId) async {
    setLoading(true);
    await _repository.getDiagnosisDetails(sessionId).then((diagnosticModel) {
      update(diagnosticModel);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  @override
  void dispose() {
    mediktorDiagnosisStore.destroy();
  }
}
