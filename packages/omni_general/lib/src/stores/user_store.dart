import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

class UserStore extends NotifierStore<Exception, PreferencesModel> with Disposable {
  final PreferencesService _service = PreferencesService();
  final BeneficiaryRepository _repository = Modular.get();
  final FirebaseService firebaseService = Modular.get();

  UserStore()
      : super(
          PreferencesModel(
            pairedDevices: PairedDevicesModel(
              accuCheckGuideList: [],
              nonin3230List: [],
              td3128List: [],
              td8255List: [],
            ),
          ),
        );

  Future<PreferencesModel?> updateUser() async {
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

  Future<void> setUserPreferences(PreferencesModel prefs, String userId) async {
    await _service.getUserPreferences(userId).then((preferences) {
      prefs.jwt = prefs.jwt ?? preferences.jwt;
      prefs.oprConfigs = prefs.oprConfigs ?? preferences.oprConfigs;
      prefs.beneficiary = prefs.beneficiary ?? preferences.beneficiary;
      prefs.primaryColor = prefs.primaryColor ?? preferences.primaryColor;
      prefs.renderViewType = prefs.renderViewType ?? preferences.renderViewType;
      prefs.pairedDevices = prefs.pairedDevices ?? preferences.pairedDevices;
      update(prefs);
    });
    await _service.setUserPreferences(prefs);
  }

  Future<BeneficiaryModel> getBeneficiaryById(String userId) async {
    return _repository.getBeneficiaryById(userId).then((beneficiary) async {
      await _service.getUserPreferences(userId).then((prefs) async {
        if (prefs.beneficiary!.lecuponUser != null) {
          beneficiary.lecuponUser = prefs.beneficiary!.lecuponUser;
        }
        prefs.beneficiary = beneficiary;
        beneficiary.programs?.sort((a, b) => a.name!.compareTo(b.name!));
        prefs.primaryColor = int.tryParse(
          '0xFF${beneficiary.programSelected!.enterprise!.primaryColor!}',
        );
        beneficiary.programSelected!.currentPhase?.modules?.sort(
          (a, b) => a.name!.compareTo(b.name!),
        );
        await setUserPreferences(prefs, userId);
      });
      return beneficiary;
    }).catchError((onError) {
      throw onError;
    });
  }

  Future<OperatorConfigsModel> getOperatorConfigs([String? userId]) async {
    return _repository.getOperatorConfigs().then((oprConfigs) async {
      final PreferencesModel prefs = PreferencesModel();
      prefs.oprConfigs = oprConfigs;
      if (userId != null) await setUserPreferences(prefs, userId);
      return oprConfigs;
    }).catchError((onError) async {
      throw onError;
    });
  }

  ProgramModel get programSelected => state.beneficiary!.programSelected!;
  OperatorConfigsModel get oprConfigs => state.oprConfigs!;
  BeneficiaryModel get beneficiary => state.beneficiary!;
  RenderViewType get viewType => state.renderViewType!;
  String get userId => state.jwt!.id!;

  Color? get programColor {
    return state.primaryColor == null ? null : Color(state.primaryColor!);
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
