import 'package:dio/dio.dart';
import 'package:diseases/src/core/allergy_model.dart';
import 'package:diseases/src/core/disease_results_model.dart';
import 'package:diseases/src/core/diseases_model.dart';
import 'package:diseases/src/modules/diseases/diseases_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';

class NewDiseasesStore extends NotifierStore<DioError, List> {
  final DiseasesRepository _repository = Modular.get();
  NewDiseasesStore() : super([]);
  final QueryParamsModel params = QueryParamsModel(limit: '10');

  DiseasesBaseResults generalDiseases = DiseasesBaseResults(results: []);

  Future<void> getCidList(QueryParamsModel params) async {
    setLoading(true);
    await _repository.getCidList(params).then(
      (diseases) {
        generalDiseases = diseases;
        setLoading(false);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        throw onError;
      },
    );
  }

  Future<void> saveDisease(DiseasesModel data) async {
    setLoading(true);
    await _repository.saveDisease(data).then(
      (value) {
        setLoading(false);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        throw onError;
      },
    );
  }

  Future<void> removeDisease(String id) async {
    setLoading(true);
    await _repository.removeDisease(id).then(
      (value) {
        setLoading(false);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        throw onError;
      },
    );
  }

  Future<void> removeAllergy(String id) async {
    setLoading(true);
    await _repository.removeAllergy(id).then(
      (value) {
        setLoading(false);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        throw onError;
      },
    );
  }

  Future<void> saveAllergy(AllergyModel data) async {
    setLoading(true);
    await _repository.saveAllergy(data).then((value) {
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
    setLoading(false);
  }
}
