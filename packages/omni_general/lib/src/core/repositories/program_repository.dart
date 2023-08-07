import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show DioHttpClientImpl, ProgramModel;

class ProgramRepository extends Disposable {
  final DioHttpClientImpl _client;

  ProgramRepository(this._client);

  Future<List<ProgramModel>?> getPrograms([Map<String, String>? params]) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/psp/',
        queryParameters: params,
      );
      final List<ProgramModel> programs = List.empty(growable: true);
      response.data.forEach(
        (module) => programs.add(ProgramModel.fromJson(module)),
      );
      return programs;
    } on DioError catch (e) {
      log('getPrograms: $e');
      rethrow;
    }
  }

  Future<ProgramModel?> changeProgramSelected(String id) async {
    try {
      final Response response =
          await _client.get(path: '/mobile/omni/psp/$id/');
      return ProgramModel.fromJson(response.data);
    } on DioError catch (e) {
      log('changeProgramSelected: $e');
      rethrow;
    }
  }

  Future<ProgramModel?> inactivateProgramSelected(
    Map<String, String> data,
    String id,
  ) async {
    try {
      final Response response = await _client.patch(
        path: '/mobile/omni/psp/$id/',
        data: data,
      );
      return ProgramModel.fromJson(response.data);
    } on DioError catch (e) {
      log('inactivateProgramSelected: $e');
      rethrow;
    }
  }

  Future<ProgramModel?> addNewProgram(Map<String, String> data) async {
    try {
      final Response response = await _client.post(
        path: '/mobile/omni/psp/',
        data: data,
      );
      return ProgramModel.fromJson(response.data);
    } on DioError catch (e) {
      log('inactivateProgramSelected: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
