import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_mediktor/src/core/models/mediktor_diagnosis_model.dart';
import 'package:omni_mediktor/src/core/models/token_mediktor_model.dart';
import 'package:omni_mediktor/src/mediktor_repository.dart';

class MediktorDiagnosisStore extends NotifierStore<DioError, TokenMediktorModel>
    with Disposable {
  final MediktorRepository _repository = Modular.get();
  MediktorDiagnosisModel diagnosis = MediktorDiagnosisModel();

  MediktorDiagnosisStore() : super(TokenMediktorModel());

  Future<void> authenticate() async {
    setLoading(true);
    await _repository.authenticate().then((token) {
      update(token);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  void onFinishSessionEnableButton(TokenMediktorModel model) {
    update(TokenMediktorModel.fromJson(model.toJson()));
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
