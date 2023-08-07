import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_plan/src/core/models/coparticipation_extract_model.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/coparticipation_extract_repository.dart';

class ItemExtractStore
    extends NotifierStore<DioError, CoparticipationExtractModel> {
  ItemExtractStore()
      : super(
          CoparticipationExtractModel(),
        );

  final CoparticipationExtractRepository _repository = Modular.get();

  Future<void> getItemExtract(String idExtract) async {
    setLoading(true);
    await _repository.getItemExtract(idExtract).then((extract) {
      update(extract);
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      throw e;
    });
  }

  void updateState() {
    update(CoparticipationExtractModel.fromJson(state.toJson()));
  }
}
