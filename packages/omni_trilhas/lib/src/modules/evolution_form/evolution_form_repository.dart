import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/evolution_form_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/doctor_evolution_form/evolution_form_doctor_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/evolution_form_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/generic_evolution_form/generic_evolution_form.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/nurse_evolution_form/nurse_evolution_form_model.dart';

class EvolutionFormRepository extends Disposable {
  final DioHttpClientImpl _client;

  EvolutionFormRepository(this._client);

  Future<List<EvolutionFormModel>> getEvolutionsList(
      EvolutionFormType evolutionFormType) async {
    try {
      final Response<dynamic> response = await _client.get(
        path: evolutionFormType.url,
      );

      final List<EvolutionFormModel> evolutionList = List.empty(growable: true);
      response.data.forEach((evolution) {
        evolutionList.add(
          EvolutionFormModel.fromJson(evolution),
        );
      });

      return evolutionList;
    } on DioError catch (e) {
      log('getEvolutionsList: $e');
      rethrow;
    }
  }

  Future<EvolutionFormDoctorModel> getMedicalEvolutionById(String id) async {
    try {
      final Response response =
          await _client.get(path: '/mobile/omni/formulario-medico/$id/');
      return EvolutionFormDoctorModel.fromJson(response.data);
    } on DioError catch (e) {
      log('getMedicalEvolutionById: $e');
      rethrow;
    }
  }

  Future<NurseEvolutionFormModel> getNurseEvolutionById(String id) async {
    try {
      final Response<dynamic> response = await _client.get(
        path: '/mobile/omni/formulario-enfermagem/$id',
      );
      return NurseEvolutionFormModel.fromJson(response.data);
    } catch (e) {
      log('getNurseEvolutionById: $e');
      rethrow;
    }
  }

  Future<GenericEvolutionFormModel> getGenericEvolutionByIdType(
    String id,
    EvolutionFormType evolutionFormType,
  ) async {
    try {
      final Response<dynamic> response = await _client.get(
        path: '${evolutionFormType.url}$id/',
      );
      return GenericEvolutionFormModel.fromJson(response.data);
    } catch (e) {
      log('getNurseEvolutionById: $e');
      rethrow;
    }
  }

  // Future<GenericEvolutionFormModel> getPhysiotherapyEvolutionById(String id) async {
  //   try {
  //     final Response<dynamic> response = await _client.get(
  //       path: '/mobile/omni/formulario-fisioterapia/$id',
  //     );
  //     return GenericEvolutionFormModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     log('getPhysiotherapyEvolutionById: $e');
  //     rethrow;
  //   }
  // }

  // Future<GenericEvolutionFormModel> getNutritionistEvolutionById(String id) async {
  //   try {
  //     final Response<dynamic> response = await _client.get(
  //       path: '/mobile/omni/formulario-nutricionista/$id',
  //     );
  //     return GenericEvolutionFormModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     log('getNutritionistEvolutionById: $e');
  //     rethrow;
  //   }
  // }

  // Future<GenericEvolutionFormModel> getPsychologistEvolutionById(String id) async {
  //   try {
  //     final Response<dynamic> response = await _client.get(
  //       path: '/mobile/omni/formulario-nutricionista/$id',
  //     );
  //     return GenericEvolutionFormModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     log('getPsychologistEvolutionById: $e');
  //     rethrow;
  //   }
  // }

  // Future<GenericEvolutionFormModel> getNursingTechnicianEvolutionById(String id) async {
  //   try {
  //     final Response<dynamic> response = await _client.get(
  //       path: '/mobile/omni/formulario-nutricionista/$id',
  //     );
  //     return GenericEvolutionFormModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     log('getNursingTechnicianEvolutionById: $e');
  //     rethrow;
  //   }
  // }

  // Future<GenericEvolutionFormModel> getTherapistEvolutionById(String id) async {
  //   try {
  //     final Response<dynamic> response = await _client.get(
  //       path: '/mobile/omni/formulario-nutricionista/$id/',
  //     );
  //     return GenericEvolutionFormModel.fromJson(response.data);
  //   } on DioError catch (e) {
  //     log('getTherapistEvolutionById: $e');
  //     rethrow;
  //   }
  // }

  @override
  void dispose() {}
}
