import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/extract_beneficiary_model.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/coparticipation_extract_repository.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/stores/extract_pdf_store.dart';
import 'package:omni_plan/src/modules/coparticipation_extract/stores/item_extract_store.dart';

class CoparticipationExtractStore
    extends NotifierStore<DioError, ExtractBeneficiaryModel> {
  CoparticipationExtractStore()
      : super(
          ExtractBeneficiaryModel(),
        );

  final CoparticipationExtractRepository _repository = Modular.get();
  DateTime? initialDateTime;
  DateTime? finalDateTime;
  final ItemExtractStore itemExtractStore = Modular.get();
  final ExtractPdfStore extractPdfStore = Modular.get();

  Future<void> getExtractBeneficiary() async {
    setLoading(true);

    final String initialDate = Formaters.dateToStringDate(initialDateTime!);
    final String finalDate = Formaters.dateToStringDate(finalDateTime!);
    await _repository
        .getExtractsBeneficiary(initialDate, finalDate)
        .then((extracts) {
      update(extracts);
      setLoading(false);
    }).catchError((e) {
      setLoading(false);
      setError(e);
    });
  }

  void updateState() {
    update(ExtractBeneficiaryModel.fromJson(state.toJson()));
  }
}
