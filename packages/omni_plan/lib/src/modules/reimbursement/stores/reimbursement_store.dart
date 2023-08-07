import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_plan/src/core/models/reimbursements_results_model.dart';
import 'package:omni_plan/src/modules/reimbursement/reimbursement_repository.dart';

class ReimbursementStore
    extends NotifierStore<DioError, ReimbursementListResultsModel> {
  final ReimbursementRepository _repository = Modular.get();

  ReimbursementStore() : super(ReimbursementListResultsModel(results: []));

  Future<void> getReimbursements() async {
    setLoading(true);
    await _repository.getReimbursements().then((reimbursementList) {
      setLoading(false);
      update(reimbursementList);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
    setLoading(false);
  }
}
