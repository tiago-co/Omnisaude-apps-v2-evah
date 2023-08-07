import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/bank_model.dart';
import 'package:omni_plan/src/modules/reimbursement/reimbursement_repository.dart';

class BanksListStore extends NotifierStore<DioError, BanksListResultsModel>
    with Disposable {
  final ReimbursementRepository _repository = Modular.get();
  BanksListStore() : super(BanksListResultsModel(results: []));
  QueryParamsModel params = QueryParamsModel(limit: '10');

  Timer? _debounce;

  Future<void> getAvaliableBanks(
    QueryParamsModel params,
  ) async {
    setLoading(true);
    await _repository.getAvaliableBanks(params).then((banks) async {
      update(banks, force: true);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
    setLoading(false);
  }

  Future<void> getAvaliableBanksParams(
    String? input,
  ) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      params.name = input;
      await getAvaliableBanks(params);
    });
  }

  Future<void> updateState() async {
    await getAvaliableBanks(params);
  }

  @override
  void dispose() {
    _debounce?.cancel();
  }
}
