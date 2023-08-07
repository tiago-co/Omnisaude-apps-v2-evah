import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/core/models/vaccine_category_model.dart';
import 'package:omni_core/src/app/core/models/vaccine_model.dart';

class VaccineRepository extends Disposable {
  Future<List<VaccineModel>> getVaccines() async {
    try {
      final List<VaccineCategoryModel> vaccineCategory = [
        VaccineCategoryModel(
          id: '1',
          name: 'Covid-19',
        ),
        VaccineCategoryModel(
          id: '2',
          name: 'Influeza',
        ),
        VaccineCategoryModel(
          id: '3',
          name: 'H1N1',
        ),
        VaccineCategoryModel(
          id: '4',
          name: 'Hepatite',
        ),
      ];

      final List<VaccineModel> vaccineList = [
        VaccineModel(
          id: '1',
          name: 'Vacina contra a Covid-19',
          category: vaccineCategory[0],
          description: 'Vacina contra a Covid-19',
          dose: '1',
          lot: 'RRP123',
          date: '05/05/2021',
          validate: '05/05/2022',
          laboraty: 'Laboratório 1',
          vaccination: 'R. 3, 1022 - St. Oeste, Goiânia - GO, 74115-050',
          professional: '25687412',
        ),
        VaccineModel(
          id: '2',
          name: 'Vacina contra a Influeza',
          category: vaccineCategory[1],
          description: 'Vacina contra a Influeza',
          dose: '1',
          lot: 'ABC123',
          date: '08/06/2020',
          validate: '05/05/2021',
          laboraty: 'Laboratório 2',
          vaccination: 'R. 3, 1022 - St. Oeste, Goiânia - GO, 74115-050',
          professional: '5698',
        ),
        VaccineModel(
          id: '3',
          name: 'Vacina contra a H1N1',
          category: vaccineCategory[2],
          description: 'Vacina contra a H1N1',
          dose: '1',
          lot: 'ABC456',
          date: '05/05/2012',
          validate: '05/05/2020',
          laboraty: 'Laboratório 3',
          vaccination: 'R. 3, 1022 - St. Oeste, Goiânia - GO, 74115-050',
          professional: '98563',
        ),
        VaccineModel(
          id: '4',
          name: 'Vacina contra a Hepatite',
          category: vaccineCategory[3],
          description: 'Vacina contra a Hepatite',
          dose: '1',
          lot: 'XYZ987',
          date: '05/05/2012',
          validate: '05/05/2020',
          laboraty: 'Laboratório 4',
          vaccination: 'R. 3, 1022 - St. Oeste, Goiânia - GO, 74115-050',
          professional: '4697',
        ),
      ];
      return vaccineList;
    } on DioError catch (e) {
      log('getTerms: $e');
      rethrow;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
