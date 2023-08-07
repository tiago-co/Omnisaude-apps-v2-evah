import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_caregiver/src/caregivers/caregivers_store.dart';
import 'package:omni_caregiver/src/caregivers_repository.dart';
import 'package:omni_caregiver/src/core/models/caregiver_model.dart';

// ignore: must_be_immutable
class CaregiverDetailsStore extends NotifierStore<DioError, CaregiverModel>
    with Disposable {
  final CaregiversRepository _repository = Modular.get();
  final CaregiversStore caregiverStore = Modular.get();

  CaregiverDetailsStore() : super(CaregiverModel());
  bool smsCheck = false;
  bool emailCheck = false;
  Future<void> removeCaregiverById(String id) async {
    setLoading(true);
    await _repository.removeCaregiverById(id).then((value) async {
      caregiverStore.params.limit = '10';
      await caregiverStore.getCaregivers(caregiverStore.params);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
      throw onError;
    });
  }

  Future<void> updateField(Map<String, dynamic> data) async {
    setLoading(true);
    await _repository.updateCaregiver(data, state.id!).then((caregiver) {
      update(caregiver!);
      caregiverStore.getCaregivers(caregiverStore.params);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
  }

  void onChangeSMSCheck(bool value) {
    smsCheck = value;
    state.sendSMS = value;
    updateField({'envio_sms': value}).then((value) => null);
  }

  void onChangeEmailCheck(bool value) {
    emailCheck = value;
    state.sendEmail = value;
    updateField({'envio_email': value}).then((value) => null);
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
