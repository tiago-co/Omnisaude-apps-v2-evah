import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';

class DiseaseTypeFilterStore extends NotifierStore<DioError, int> {
  DiseaseTypeFilterStore(int initialState) : super(0);

  void updateStore(int index) {
    update(index);
  }
}
