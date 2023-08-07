import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../../core/allergy_model.dart';

class AllergyStore extends NotifierStore<DioError, AllergyModel> {
  AllergyStore() : super(AllergyModel());

  void updateForm(AllergyModel model) {
    update(AllergyModel.fromJson(model.toJson()));
  }
}
