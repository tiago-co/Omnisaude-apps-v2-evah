import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/new_drug_control/new_drug_control_repository.dart';
import 'package:omni_general/omni_general.dart' show KeyValueModel;

class NewDrugControlUnityStore
    extends NotifierStore<DioError, List<KeyValueModel>> with Disposable {
  final NewDrugControlRepository _repository = Modular.get();

  NewDrugControlUnityStore() : super([]);

  Future<void> getUnities() async {
    setLoading(true);

    await _repository.getUnities().then((unities) {
      update(unities!);
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
