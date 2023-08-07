import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_plan/src/core/models/plan_token_model.dart';
import 'package:omni_plan/src/modules/plan_card/plan_card_repository.dart';

class PlanTokenStore extends NotifierStore<DioError, PlanTokenModel> {
  PlanTokenStore() : super(PlanTokenModel());

  final PlanCardRepository _repository = Modular.get();

  Future<void> getPlanToken() async {
    setLoading(true);
    await _repository.getPlanToken().then((planToken) {
      update(planToken);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      log(onError.toString());
      setError(onError);
    });
  }
}
