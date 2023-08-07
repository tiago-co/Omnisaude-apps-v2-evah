import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_mediktor/src/core/models/recomendation_modules_model.dart';

import 'package:omni_mediktor/src/mediktor_repository.dart';

class RecomendationStore
    extends NotifierStore<DioError, RecomendationModulesModel> with Disposable {
  final MediktorRepository _repository = Modular.get();

  RecomendationStore()
      : super(
          RecomendationModulesModel(
            bot: false,
            measurement: false,
            informative: false,
            schedule: false,
          ),
        );

  Future<void> getModules(String specialtyId) async {
    setLoading(true);

    await _repository.getModules(specialtyId).then((value) {
      update(value);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });

    setLoading(false);
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
