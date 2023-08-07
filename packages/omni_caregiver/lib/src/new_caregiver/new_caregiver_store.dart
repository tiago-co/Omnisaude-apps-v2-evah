import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_caregiver/src/caregivers_repository.dart';
import 'package:omni_caregiver/src/core/models/caregiver_model.dart';

// ignore: must_be_immutable
class NewCaregiverStore extends NotifierStore<DioError, CaregiverModel>
    with Disposable {
  final CaregiversRepository _repository = Modular.get();

  NewCaregiverStore()
      : super(
          CaregiverModel(
            sendEmail: false,
            sendSMS: false,
            name: '',
            cpf: '',
            phones: [''],
            emails: [''],
          ),
        );

  int activePage = 0;
  bool smsCheck = false;
  bool emailCheck = false;
  final List<int> emails = List.generate(1, (_) => 0);
  final List<int> phones = List.generate(1, (_) => 0);

  Future<void> createCaregiver(CaregiverModel data) async {
    setLoading(true);
    data.emails!.removeWhere((email) {
      if (email.isEmpty) {
        emails.removeAt(data.emails!.indexOf(email));
        return true;
      }
      return false;
    });
    data.phones!.removeWhere((phone) {
      if (phone.isEmpty) {
        phones.removeAt(data.phones!.indexOf(phone));
        return true;
      }
      return false;
    });
    await _repository.createCaregiver(data).then((caregiver) {
      update(caregiver!);
      activePage = 1;
      setLoading(false);
    }).catchError((onError) {
      if (emails.isEmpty) addEmail();
      if (phones.isEmpty) addPhone();
      setLoading(false);
      setError(onError);
      throw onError;
    });
  }

  void addPhone() {
    setLoading(true);
    if (phones.length < 5) {
      phones.add(phones.length);
      state.phones!.add('');
    }
    setLoading(false);
  }

  void removePhone() {
    setLoading(true);
    if (phones.length > 1) {
      phones.removeLast();
      state.phones!.removeLast();
    }
    setLoading(false);
  }

  void addEmail() {
    setLoading(true);
    if (emails.length < 5) {
      emails.add(emails.length);
      state.emails!.add('');
    }
    setLoading(false);
  }

  void removeEmail() {
    setLoading(true);
    if (emails.length > 1) {
      emails.removeLast();
      state.emails!.removeLast();
    }
    setLoading(false);
  }

  void onChangeSMSCheck(bool value) {
    setLoading(true);
    smsCheck = value;
    state.sendSMS = value;
    update(state);
    setLoading(false);
  }

  void onChangeEmailCheck(bool value) {
    setLoading(true);
    emailCheck = value;
    state.sendEmail = value;
    update(state);
    setLoading(false);
  }

  bool isDisabled() {
    return state.name!.isEmpty || state.cpf!.isEmpty;
    // state.cpf!.isEmpty ||
    //     (smsCheck && !state.phones!.any((phone) => phone.isNotEmpty)) ||
    //     (emailCheck && !state.emails!.any((email) => email.isNotEmpty));
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
