import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/new_drug_control/new_drug_control_repository.dart';
import 'package:omni_general/omni_general.dart' show KeyValueModel;

class NewDrugControlAdministrationStore
    extends NotifierStore<DioError, List<KeyValueModel>> with Disposable {
  final NewDrugControlRepository _repository = Modular.get();

  NewDrugControlAdministrationStore() : super([]);

  Future<void> getAdministrations() async {
    setLoading(true);
    await _repository.getAdministrations().then((administrations) {
      update(administrations!);
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
