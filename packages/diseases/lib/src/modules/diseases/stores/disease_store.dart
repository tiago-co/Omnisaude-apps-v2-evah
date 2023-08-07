import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../core/diseases_model.dart';

class DiseaseStore extends NotifierStore<DioError, DiseasesModel> {
  DiseaseStore() : super(DiseasesModel());

  void updateForm(DiseasesModel model) {
    update(DiseasesModel.fromJson(model.toJson()));
  }
}
