import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/new_reimbursement_model.dart';
import 'package:omni_plan/src/modules/reimbursement/reimbursement_repository.dart';

class NewReimbursementStore
    extends NotifierStore<DioError, NewReimbursementModel> {
  final ReimbursementRepository _repository = Modular.get();
  final PdfViewStore pdfStore = PdfViewStore();
  NewReimbursementStore()
      : super(
          NewReimbursementModel(
            name: '',
            email: '',
            phone: '',
            bank: '',
            agency: '',
            account: '',
            invoice: '',
            receipt: '',
            extraDocuments: [],
          ),
        );

  void updateForm(NewReimbursementModel model) {
    setLoading(true);
    update(NewReimbursementModel.fromMap(model.toMap()), force: true);
    setLoading(false);
  }

  Future<void> createReimbursementSolicitation() async {
    setLoading(true);
    await _repository.createReimbursementSolicitation(state).then((value) {
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
    setLoading(false);
  }
}
