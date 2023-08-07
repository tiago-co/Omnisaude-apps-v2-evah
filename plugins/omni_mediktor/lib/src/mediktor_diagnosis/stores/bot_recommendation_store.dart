import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_mediktor/src/core/models/recommended_bots_model.dart';
import 'package:omni_mediktor/src/mediktor_repository.dart';

class BotRecommendationStore
    extends NotifierStore<DioError, RecommendedBotsModel> with Disposable {
  BotRecommendationStore() : super(RecommendedBotsModel(recomendedBots: []));
  final MediktorRepository _repository = Modular.get();

  Future<void> getRecomendedBots(String specialtyId) async {
    setLoading(true);
     await _repository.getRecomendedBots(specialtyId).then((value) {
       setLoading(false);
       update(value);
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
