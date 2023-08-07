import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_caregiver/omni_caregiver.dart';
import 'package:omni_drug_control/src/new_drug_control/new_drug_control_repository.dart';

class NewDrugControlCaregiverNotificationsStore
    extends NotifierStore<DioError, CaregiverNotificationsModel> {
  final NewDrugControlRepository _repository =
      Modular.get<NewDrugControlRepository>();

  NewDrugControlCaregiverNotificationsStore()
      : super(CaregiverNotificationsModel());

  Future<void> updateField(
    Map<String, dynamic> data,
    String caregiverId,
  ) async {
    setLoading(true);
    await _repository
        .updateCaregiver(data, caregiverId)
        .then((caregiverNotifications) {
      update(caregiverNotifications!);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
  }

  void onChangeSMSCheck(bool value, String caregiverId) {
    state.sendSMS = value;
    updateField({'envio_sms': value}, caregiverId);
  }

  void onChangeEmailCheck(bool value, String caregiverId) {
    state.sendEmail = value;
    updateField({'envio_email': value}, caregiverId);
  }
}
