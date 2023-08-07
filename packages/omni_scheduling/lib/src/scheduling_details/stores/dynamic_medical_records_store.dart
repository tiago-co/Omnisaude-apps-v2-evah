import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/models/dynamic_medical_records_model.dart';
import 'package:omni_scheduling/src/scheduling_details/scheduling_details_repository.dart';

class DynamicMedicalRecordsStore
    extends NotifierStore<DioError, DynamicMedicalRecordsModel>
    with Disposable {
  final SchedulingDetailsRepository _repository = Modular.get();

  DynamicMedicalRecordsStore() : super(DynamicMedicalRecordsModel(fields: []));

  Future<void> getDynamicMedicalRecordsById(String id) async {
    setLoading(true);
    await _repository
        .getDynamicMedicalRecordsById(id)
        .then((medicalRecords) async {
      update(medicalRecords);
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
