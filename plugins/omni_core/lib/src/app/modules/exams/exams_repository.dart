import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/core/models/new_exam_model.dart';
import 'package:omni_general/omni_general.dart';

class ExamsRepository extends Disposable {
  late final DioHttpClientImpl _client;

  ExamsRepository(this._client);

  Future<ExamsResultsModel?> getExams([QueryParamsModel? params]) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/exame-beneficiario/',
        queryParameters: params?.toJson(),
      );
      return ExamsResultsModel.fromJson(response.data);
    } on DioError catch (e) {
      log('Create Exams: $e');
      rethrow;
    }
  }

  Future<NewExamModel> createExam(NewExamModel data) async {
    try {
      final Response response = await _client.post(
        path: '/mobile/omni/exame-beneficiario/',
        data: data,
      );
      log(response.toString());
      return NewExamModel.fromJson(response.data);
    } on DioError catch (e) {
      log('New Exam: $e');
      rethrow;
    }
  }

  Future<NewExamModel> editExam(NewExamModel data, String? id) async {
    try {
      final Response response = await _client.patch(
        path: '/mobile/omni/exame-beneficiario/$id/',
        data: data,
      );
      return NewExamModel.fromJson(response.data);
    } on DioError catch (e) {
      log('Exam Detail: $e');
      rethrow;
    }
  }

  Future<NewExamModel> getDetailExam(String? id) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/exame-beneficiario/$id/',
      );
      return NewExamModel.fromJson(response.data);
    } on DioError catch (e) {
      log('Exam Detail: $e');
      rethrow;
    }
  }

  Future<void> removeExam(String? id) async {
    try {
      await _client.delete(
        path: '/mobile/omni/exame-beneficiario/$id/',
      );
    } on DioError catch (e) {
      log('Exam Detail: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
