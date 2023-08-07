import 'package:dio/dio.dart';
import 'package:diseases/src/core/allergies_list_results_model.dart';
import 'package:diseases/src/modules/diseases/diseases_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class AllergiesListStore
    extends NotifierStore<DioError, AllergiesListBaseResults> {
  final DiseasesRepository _repository = Modular.get();
  AllergiesListStore() : super(AllergiesListBaseResults(results: []));

  Future<void> getAllergiesList() async {
    setLoading(true);

    await _repository.getAllergiesList().then(
      (allergies) {
        setLoading(false);
        update(allergies);
      },
    ).catchError((onError) {
      setLoading(false);
      throw onError;
    });

    setLoading(false);
  }
}
