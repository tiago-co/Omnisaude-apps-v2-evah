import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/informative_model.dart';
import 'package:omni_core/src/app/core/models/informative_params_model.dart';
import 'package:omni_core/src/app/modules/informatives/informatives_repository.dart';

// ignore: must_be_immutable
class InformativesStore extends NotifierStore<DioError, InformativeResultsModel>
    with Disposable {
  final InformativesRepository _repository = Modular.get();
  final InformativeParamsModel params = InformativeParamsModel();

  InformativesStore() : super(InformativeResultsModel(results: []));

  Timer? _debounce;

  Future<void> getInformatives(InformativeParamsModel params) async {
    setLoading(true);
    await _repository.getInformatives(params).then((informatives) {
      update(informatives!);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> getInformativesByName(
    String? informative,
    InformativeParamsModel params,
  ) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      params.title = informative ?? '';
      await getInformatives(params);
    });
  }

  @override
  void dispose() {
    _repository.dispose();
    _debounce?.cancel();
  }
}
