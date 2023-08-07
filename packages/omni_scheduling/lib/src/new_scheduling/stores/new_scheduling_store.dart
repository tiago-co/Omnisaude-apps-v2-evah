import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_type_enum.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling/src/core/models/scheduling_params_model.dart';
import 'package:omni_scheduling/src/core/repositories/scheduling_repository.dart';

// ignore: must_be_immutable
class NewSchedulingStore extends NotifierStore<DioError, NewSchedulingModel>
    with Disposable {
  final SchedulingParamsModel params = SchedulingParamsModel();
  final SchedulingRepository _repository = Modular.get();

  int categoryStep = 0;

  NewSchedulingStore() : super(NewSchedulingModel(reason: ''));

  void updateForm(NewSchedulingModel form) {
    update(NewSchedulingModel.fromJson(form.toJson()));
  }

  void onChangeSchedulingType(SchedulingType schedulingType) {
    final NewSchedulingModel form = NewSchedulingModel.fromJson(state.toJson());
    if (form.schedulingType == schedulingType) {
      form.schedulingType = null;
      params.type = null;
    } else {
      form.schedulingType = schedulingType;
      params.type = schedulingType.toJson;
    }
    update(form);
  }

  Future<void> onMediktorScheduling(String mediktorId) async {
    await _repository
        .getSpecialtyDetailsMediktor(mediktorId)
        .then((specialtyDetails) {
      state.mediktor = true;
      state.category = 'md';
      state.specialty = specialtyDetails.id;
      update(NewSchedulingModel.fromJson(state.toJson()));
      params.professionaType = 'md';
      params.specialty = specialtyDetails.nome;
    });
  }

  Future<void> createScheduling(NewSchedulingModel data) async {
    setLoading(true);
    data.date = '${data.date} ${data.hour}';
    await _repository.createScheduling(data).then((scheduling) {
      update(scheduling!);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
  }

  bool isSimpleButtonDisabled(int page, NewSchedulingModel form) {
    switch (page) {
      case 0:
        return form.specialty == null || form.category == null;
      case 1:
        return form.professionalId == null ||
            form.specialty == null ||
            form.category == null ||
            form.date == null ||
            form.hour == null;
      case 2:
        return form.professionalId == null ||
            form.specialty == null ||
            form.category == null ||
            form.date == null ||
            form.hour == null;
      case 3:
        return false;
    }
    return true;
  }

  bool isMediktorButtonDisabled(int page, NewSchedulingModel form) {
    switch (page) {
      case 0:
        return form.professionalId == null ||
            form.date == null ||
            form.hour == null;
      case 1:
        return form.professionalId == null ||
            form.date == null ||
            form.hour == null;
      case 2:
        return false;
    }
    return true;
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
