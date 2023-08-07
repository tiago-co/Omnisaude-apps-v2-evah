import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_plan/src/core/models/tax_demonstrative_model.dart';
import 'package:omni_plan/src/modules/income_tax_statement/income_tax_statement_repository.dart';

class IncomeTaxStatementStore
    extends NotifierStore<DioError, List<TaxDemonstrativeModel>>
    with Disposable {
  final IncomeTaxStatementRepository _repository = Modular.get();

  IncomeTaxStatementStore() : super([]);

  Future<void> getTaxDemonstrativeData() async {
    setLoading(true);
    await _repository.getTaxDemonstrativeData().then((listIncomeTax) {
      update(listIncomeTax);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
