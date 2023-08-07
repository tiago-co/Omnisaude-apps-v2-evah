import 'package:dio/dio.dart';
import 'package:diseases/src/modules/diseases/diseases_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../core/diseases_list_results_model.dart';

class DiseasesListStore
    extends NotifierStore<DioError, DiseasesListBaseResults> {
  final DiseasesRepository _repository = Modular.get();
  DiseasesListStore() : super(DiseasesListBaseResults(results: []));

  Future<void> getDiseasesList() async {
    setLoading(true);

    await _repository.getDiseasesList().then(
      (diseases) {
        setLoading(false);
        update(diseases);
      },
    ).catchError((onError) {
      setLoading(false);
      throw onError;
    });

    setLoading(false);
  }
}
