import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show PathUtils, DioHttpClientImpl;
import 'package:omni_scheduling/src/core/models/dynamic_medical_records_model.dart';
import 'package:omni_scheduling/src/core/models/medical_records_model.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';

class SchedulingDetailsRepository extends Disposable {
  final DioHttpClientImpl _client;

  SchedulingDetailsRepository(this._client);

  Future<SchedulingModel> getSchedulingById(String id) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/agendamentos/$id/',
      );
      return SchedulingModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getSchedulings: $e');
      rethrow;
    }
  }

  Future<SchedulingModel> updateSchedulingById(
    String id,
    Map<String, String> data,
  ) async {
    try {
      final Response response = await _client.patch(
        path: '/acao-agendamento/$id/',
        data: data,
      );
      return SchedulingModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getSchedulings: $e');
      rethrow;
    }
  }

  Future<String> getPrescriptionById(String id) async {
    try {
      final Response response = await _client.get(
        path: '/ver_receituario/$id/',
      );
      return response.data['url_pdf'];
    } on DioError catch (e) {
      log('getPrescriptionById: $e');
      rethrow;
    }
  }

  Future<File> getMedicalCertificateByCode(String code) async {
    try {
      final Response response = await _client.get(
        path: '/atestado/download/$code/',
      );
      final String filename = response.headers.map['x-file-name']!.first
          .replaceAll(RegExp(r'[^0-9A-Za-z.-]'), '');
      final File file = File('${await PathUtils().localPath}/$filename');
      return await file.writeAsBytes(utf8.encode(response.data));
    } on DioError catch (e) {
      log('getMedicalCertificateByCode: $e');
      rethrow;
    }
  }

  Future<MedicalRecordsModel> getMedicalRecordsById(String id) async {
    try {
      final Response response =
          await _client.get(path: '/prontuario_medico/$id/');
      return MedicalRecordsModel.fromJson(response.data);
    } catch (e) {
      log('getMedicalRecordsById: $e');
      rethrow;
    }
  }

  Future<DynamicMedicalRecordsModel> getDynamicMedicalRecordsById(
    String id,
  ) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/prontuario_dinamico/$id/',
      );
      return DynamicMedicalRecordsModel.fromJson(response.data);
    } catch (e) {
      log('getDynamicMedicalRecordsById: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
