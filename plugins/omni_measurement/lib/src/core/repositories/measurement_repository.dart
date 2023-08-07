import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/omni_measurement.dart';
import 'package:omni_measurement/src/core/models/measurement_model.dart';
import 'package:omni_measurement/src/core/models/mediktor_measurement_type_model.dart';

class MeasurementRepository extends Disposable {
  final DioHttpClientImpl _client;

  MeasurementRepository(this._client);

  Future<String> _getMeasure(
    BluetoothDevice deviceBle,
    MeasurementType measurementType,
  ) async {
    String measure = '';

    for (final DeviceModelType typeDevice in measurementType.typeDevice) {
      for (final String name in typeDevice.nameScanList) {
        if (deviceBle.name.toLowerCase().contains(name.toLowerCase())) {
          measure = await typeDevice.getMeasurement(deviceBle).timeout(
                const Duration(seconds: 15),
                onTimeout: () => '0',
              );
        }
      }
    }
    return measure;
  }

  Future<String> connect(
    BluetoothDevice device,
    MeasurementType measurementType,
  ) async {
    await BluetoothServices.connectDevice(device);
    return _getMeasure(device, measurementType);
  }

  Future<String> readConnectedDevices(
    BluetoothDevice device,
    MeasurementType measurementType,
  ) async {
    return _getMeasure(device, measurementType);
  }

  Future<String> sendMeasurementOCR(String picture) async {
    final Dio dio = Dio();
    try {
      final Response response = await dio.post(
        'https://demo.ocr.omnisaude.co/api/v2/predictor/',
        data: {'b64': picture},
      );
      return response.data['result'].toString();
    } catch (e) {
      log('sendMeasurementImage: $e');
      rethrow;
    }
  }

  Future<MeasurementModel> createMeasurement(MeasurementModel data) async {
    try {
      final Response response = await _client.post(
        path: '/mobile/omni/medicao/',
        data: data,
      );
      log(data.toString());
      log(response.data.toString());

      return MeasurementModel.fromJson(response.data);
    } on DioError catch (e) {
      log('createMeasurement: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getMeasurementsDays([
    QueryParamsModel? params,
  ]) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/dia-historico-medicamento/',
        queryParameters: params?.toJson(),
      );
      return response.data;
    } on DioError catch (e) {
      log('getMeasurementsDays: $e');
      rethrow;
    }
  }

  Future<MeasurementResultsModel> getMeasurements([
    QueryParamsModel? params,
  ]) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/historico-medicamento/',
        queryParameters: params?.toJson(),
      );
      return MeasurementResultsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getMedicines: $e');
      rethrow;
    }
  }

  Future<MediktorMeasurementTypeModel> getMediktorMeasurement(
    String mediktorId,
  ) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/recomendacao/$mediktorId/medicao/',
      );
      return MediktorMeasurementTypeModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getMediktorMeasurement: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
