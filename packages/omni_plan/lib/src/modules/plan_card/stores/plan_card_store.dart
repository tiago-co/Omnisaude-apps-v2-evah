import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/plan_card_model.dart';

import 'package:omni_plan/src/modules/plan_card/plan_card_repository.dart';

class PlanCardStore extends NotifierStore<DioError, PlanCardModel>
    with Disposable {
  final PlanCardRepository _repository = Modular.get();
  final UserStore userStore = Modular.get();
  PlanCardStore() : super(PlanCardModel());
  Future<void> getPlanCard() async {
    setLoading(true);
    await _repository.getPlanCard().then((planCard) {
      update(planCard);
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
