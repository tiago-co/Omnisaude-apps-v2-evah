import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general/src/core/models/new_beneficiary_model.dart';

class UserStore extends NotifierStore<Exception, NewPreferencesModel> with Disposable {
  final PreferencesService _service = PreferencesService();
  final BeneficiaryRepository _repository = Modular.get();
  final FirebaseService firebaseService = Modular.get();

  UserStore()
      : super(
          NewPreferencesModel(),
        );

  Future<NewPreferencesModel?> updateUser() async {
    setLoading(true);
    return _service.getUserID().then((userId) async {
      if (userId == null) {
        setLoading(false);
        throw Exception();
      }
      return _service.getUserPreferences(userId).then((prefs) async {
        update(prefs);
        setLoading(false);
        return prefs;
      });
    });
  }

  Future<void> deleteUser() async {
    await _repository.deleteUser().then((value) async {
      await LogoutService.logout();
    });
  }

  Future<void> setUserPreferences(NewPreferencesModel prefs, String userId) async {
    await _service.getUserPreferences(userId).then((preferences) {
      prefs.jwt = prefs.jwt ?? preferences.jwt;
      prefs.user = prefs.user ?? preferences.user;
      update(prefs);
    });
    await _service.setUserPreferences(prefs);
  }

  Future<NewBeneficiaryModel> getBeneficiaryById(String userId) async {
    return _repository.getNewIndividualPerson(userId).then((beneficiary) async {
      final NewBeneficiaryModel user = NewBeneficiaryModel();

      await _service.getUserPreferences(userId).then((prefs) async {
        if (prefs.user!.lecuponUser != null) {
          user.lecuponUser = prefs.user!.lecuponUser;
        }
        prefs.user!.individualPerson = beneficiary;
        await setUserPreferences(prefs, userId);
      });
      return user;
    }).catchError((onError) {
      throw onError;
    });
  }

  Future<OperatorConfigsModel> getOperatorConfigs([String? userId]) async {
    return _repository.getOperatorConfigs().then((oprConfigs) async {
      final PreferencesModel prefs = PreferencesModel();
      prefs.oprConfigs = oprConfigs;
      // if (userId != null) await setUserPreferences(prefs, userId);
      return oprConfigs;
    }).catchError((onError) async {
      throw onError;
    });
  }

  NewBeneficiaryModel get beneficiary => state.user!;
  int get userId => state.jwt!.id!;

  @override
  void dispose() {
    _repository.dispose();
  }
}
