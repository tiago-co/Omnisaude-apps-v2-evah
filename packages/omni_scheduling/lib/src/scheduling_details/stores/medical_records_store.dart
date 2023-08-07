import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/models/appointment_model.dart';
import 'package:omni_scheduling/src/core/models/medical_records_model.dart';
import 'package:omni_scheduling/src/scheduling_details/scheduling_details_repository.dart';

import 'package:omni_scheduling/src/scheduling_details/stores/dynamic_medical_records_store.dart';

class MedicalRecordsStore extends NotifierStore<DioError, MedicalRecordsModel>
    with Disposable {
  final SchedulingDetailsRepository _repository = Modular.get();
  final DynamicMedicalRecordsStore dynamicStore = Modular.get();

  MedicalRecordsStore() : super(MedicalRecordsModel());

  Future<void> getMedicalRecordsById(AppointmentModel appointment) async {
    setLoading(true);
    if (appointment.pep != null) {
      await _repository
          .getMedicalRecordsById(appointment.pep!)
          .then((medicalRecords) async {
        update(medicalRecords);
        setLoading(false);
      }).catchError((onError) {
        setLoading(false);
        setError(onError);
      });
    } else if (appointment.medicalRecords != null) {
      await dynamicStore.getDynamicMedicalRecordsById(
        appointment.medicalRecords!,
      );
    }
    setLoading(false);
  }

  @override
  void dispose() {
    _repository.dispose();
    dynamicStore.destroy();
  }
}
