import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_caregiver/omni_caregiver.dart';
import 'package:omni_drug_control/src/new_drug_control/new_drug_control_repository.dart';
import 'package:omni_general/omni_general.dart';

class NewDrugControlListCaregiverStore
    extends NotifierStore<DioError, CaregiverResultsModel> with Disposable {
  final NewDrugControlRepository _repository =
      Modular.get<NewDrugControlRepository>();
  final QueryParamsModel params = QueryParamsModel(limit: '100');

  NewDrugControlListCaregiverStore()
      : super(CaregiverResultsModel(results: []));

  Future<void> getCaregivers(QueryParamsModel params) async {
    setLoading(true);
    await _repository.getCaregivers(params).then((caregivers) {
      update(caregivers!);
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
