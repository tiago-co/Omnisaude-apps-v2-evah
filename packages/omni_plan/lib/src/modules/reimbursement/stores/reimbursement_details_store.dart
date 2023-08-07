import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/reimbursement_details_model.dart';
import 'package:omni_plan/src/modules/reimbursement/reimbursement_repository.dart';

class ReimbursementDetailsStore
    extends NotifierStore<DioError, ReimbursementDetailsModel> {
  final ReimbursementRepository _repository = Modular.get();
  final PdfViewStore pdfStore = PdfViewStore();

  ReimbursementDetailsStore() : super(ReimbursementDetailsModel());

  Future<void> getReimbursementDetails(String id) async {
    setLoading(true);
    await _repository.getReimbursementDetails(id).then((details) {
      setLoading(false);
      update(details);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
    setLoading(false);
  }
}
