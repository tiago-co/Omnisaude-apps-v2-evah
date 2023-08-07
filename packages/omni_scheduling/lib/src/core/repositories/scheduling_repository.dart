import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart'
    show DioHttpClientImpl, KeyValueModel;
import 'package:omni_scheduling/src/core/models/mediktor_scheduling_model.dart';
import 'package:omni_scheduling/src/core/models/professional_model.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling/src/core/models/scheduling_params_model.dart';
import 'package:omni_scheduling/src/core/models/specialty_model.dart';

class SchedulingRepository extends Disposable {
  final DioHttpClientImpl _client;

  SchedulingRepository(this._client);

  Future<SchedulingResultsModel> getSchedules(
    SchedulingParamsModel params,
  ) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/agendamentos/',
        queryParameters: params.toJson(),
      );
      return SchedulingResultsModel.fromJson(response.data);
    } catch (e) {
      log('getSchedulings: $e');
      rethrow;
    }
  }

  Future<List<ProfessionalCategoryModel>?> getSchedulingCategory() async {
    try {
      final Response response = await _client.get(
        path: '/tipo-profissional-agendamento/',
      );
      final List<ProfessionalCategoryModel> categories = List.empty(
        growable: true,
      );
      response.data.forEach(
        (category) => categories.add(
          ProfessionalCategoryModel.fromJson(category),
        ),
      );
      return categories;
    } on DioError catch (e) {
      log('getSchedulingCategory: $e');
      rethrow;
    }
  }

  Future<MediktorSchedulingModel> getSpecialtyDetailsMediktor(
    String mediktorId,
  ) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/especialidade-mediktor/$mediktorId/',
      );
      return MediktorSchedulingModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getSpecialtyDetailsMediktor: $e');
      rethrow;
    }
  }

  Future<List<SpecialtyModel>?> getSpecialties(
    SchedulingParamsModel params,
  ) async {
    try {
      final Response response = await _client.get(
        path: '/especialidades-agendamento/',
        queryParameters: params.toJson(),
      );
      final List<SpecialtyModel> specialties = List.empty(growable: true);
      response.data.forEach((specialty) {
        specialties.add(SpecialtyModel.fromJson(specialty));
      });
      return specialties;
    } on DioError catch (e) {
      log('getSpecialties: $e');
      rethrow;
    }
  }

  Future<List<ProfessionalModel>?> getProfessionals(
    SchedulingParamsModel params,
  ) async {
    try {
      final Response response = await _client.get(
        path: '/profissional-disponivel/',
        queryParameters: params.toJson(),
      );
      final List<ProfessionalModel> professionals = List.empty(growable: true);
      response.data.forEach((professional) {
        professionals.add(ProfessionalModel.fromJson(professional));
      });
      return professionals;
    } on DioError catch (e) {
      log('getProfessionals: $e');
      rethrow;
    }
  }

  Future<List<ProfessionalAvaliableDaysModel>?> getProfessionalDays(
    String id,
    SchedulingParamsModel params,
  ) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/dia-agenda-profissional/$id/',
        queryParameters: params.toJson(),
      );
      final List<ProfessionalAvaliableDaysModel> days = List.empty(
        growable: true,
      );
      response.data.forEach(
        (day) => days.add(ProfessionalAvaliableDaysModel.fromJson(day)),
      );
      return days;
    } on DioError catch (e) {
      log('getProfessionalDays: $e');
      rethrow;
    }
  }

  Future<List<String>?> getHoursByProfessional(
    String id,
    SchedulingParamsModel params,
  ) async {
    try {
      final Response response = await _client.get(
        path: '/agenda-profissional/$id/',
        queryParameters: params.toJson(),
      );
      final List<String> hours = List.empty(growable: true);
      response.data.forEach((hour) => hours.add(hour));
      return hours;
    } on DioError catch (e) {
      log('getHoursByProfessional: $e');
      rethrow;
    }
  }

  Future<List<KeyValueModel>?> getSchedulingReasons() async {
    try {
      final Response response = await _client.get(
        path: '/mobile/motivo-agendamento/',
      );
      final List<KeyValueModel> reasons = List.empty(growable: true);
      response.data.forEach((reason) {
        reasons.add(KeyValueModel.fromJson(reason));
      });
      return reasons;
    } on DioError catch (e) {
      log('getSchedulingReasons: $e');
      rethrow;
    }
  }

  Future<NewSchedulingModel?> createScheduling(NewSchedulingModel data) async {
    try {
      final Response response = await _client.post(
        path: '/agendamentos/',
        data: data,
      );

      return NewSchedulingModel.fromJson(response.data);
    } on DioError catch (e) {
      log('createScheduling: $e');
      rethrow;
    }
  }

  Future<SpecialtyResults?> getSpecialtiesParams(String? specialty) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/especialidade/',
        queryParameters: {'nome': specialty},
      );
      return SpecialtyResults.fromJson(response.data);
    } on DioError catch (e) {
      log('getSpecialtiesParams: $e');
      rethrow;
    }
  }

  Future<ProfessionalResults?> getProfessionalParams(
    String? professional,
  ) async {
    try {
      final Response response = await _client.get(
        path: '/mobile/omni/profissional-saude/',
        queryParameters: {'nome': professional},
      );
      return ProfessionalResults.fromJson(response.data);
    } on DioError catch (e) {
      log('getProfessionalParams: $e');
      rethrow;
    }
  }

  @override
  void dispose() {}
}
