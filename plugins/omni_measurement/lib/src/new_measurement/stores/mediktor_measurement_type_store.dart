import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_measurement/src/core/models/mediktor_measurement_type_model.dart';
import 'package:omni_measurement/src/core/repositories/measurement_repository.dart';

class MediktorMeasurementTypeStore
    extends NotifierStore<DioError, MediktorMeasurementTypeModel> {
  MediktorMeasurementTypeStore() : super(MediktorMeasurementTypeModel());

  final MeasurementRepository _repository =
      Modular.get<MeasurementRepository>();

  Future<void> getMediktorMeasurementsType(String mediktorId) async {
    setLoading(true);
    await _repository.getMediktorMeasurement(mediktorId).then((value) {
      update(value);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }
}
