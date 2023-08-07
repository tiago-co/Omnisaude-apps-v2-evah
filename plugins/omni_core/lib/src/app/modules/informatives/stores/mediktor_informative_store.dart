import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/informative_model.dart';
import 'package:omni_core/src/app/modules/informatives/informatives_repository.dart';

// ignore: must_be_immutable
class MediktorInformativesStore
    extends NotifierStore<DioError, MediktorInformativeResultsModel>
    with Disposable {
  final InformativesRepository _repository = Modular.get();

  MediktorInformativesStore()
      : super(MediktorInformativeResultsModel(results: []));

  Future<void> getMediktorInformatives(String mediktorId) async {
    setLoading(true);
    await _repository.getMediktorInformatives(mediktorId).then((informatives) {
      update(informatives);
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
