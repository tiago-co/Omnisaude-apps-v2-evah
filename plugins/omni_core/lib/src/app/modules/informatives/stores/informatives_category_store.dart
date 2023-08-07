import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/category_informative_model.dart';
import 'package:omni_core/src/app/core/models/informative_params_model.dart';
import 'package:omni_core/src/app/modules/informatives/informatives_repository.dart';

// ignore: must_be_immutable
class InformativesCategoryStore
    extends NotifierStore<DioError, CategoryInformativeModelResultsModel>
    with Disposable {
  final InformativeParamsModel params = InformativeParamsModel();
  final InformativesRepository _repository = Modular.get();

  InformativesCategoryStore()
      : super(CategoryInformativeModelResultsModel(results: []));

  Timer? _debounce;

  Future<void> getCategories(InformativeParamsModel params) async {
    setLoading(true);
    await _repository.getCategories(params).then((categories) {
      update(categories!);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> getCategoriesByName(
    String category,
    InformativeParamsModel params,
  ) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () async {
      params.name = category;
      await getCategories(params);
    });
  }

  @override
  void dispose() {
    _repository.dispose();
    _debounce?.cancel();
  }
}
