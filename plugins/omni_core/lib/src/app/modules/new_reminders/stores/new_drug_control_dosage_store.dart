import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/new_reminders/repository/new_drug_control_repository.dart';

import 'package:omni_general/omni_general.dart' show KeyValueModel;

class NewDrugControlDosageStore extends NotifierStore<DioError, List<KeyValueModel>> with Disposable {
  final NewDrugControlRepository _repository = Modular.get();

  NewDrugControlDosageStore() : super([]);

  Future<void> getDosages() async {
    setLoading(true);
    await _repository.getDosages().then((dosages) {
      update(dosages!);
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
