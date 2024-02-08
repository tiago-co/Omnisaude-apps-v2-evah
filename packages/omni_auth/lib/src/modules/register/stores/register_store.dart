import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/auth_repository.dart';
import 'package:omni_auth/src/modules/register/register_repository.dart';
import 'package:omni_general/omni_general.dart'
    show
        AddressModel,
        BeneficiaryModel,
        BeneficiaryRepository,
        Formaters,
        IndividualPersonModel,
        JwtModel,
        LecuponRepository,
        LecuponService,
        NewBeneficiaryModel,
        NewJwtModel,
        NewPreferencesModel,
        PreferencesModel,
        PreferencesService,
        UserModel,
        UserStore,
        ZipCodeStore;

class RegisterStore extends NotifierStore<DioError, NewBeneficiaryModel> with Disposable {
  final RegisterRepository _repository = Modular.get();
  final AuthRepository _authRepository = Modular.get();
  final BeneficiaryRepository _beneficiaryRepository = Modular.get();
  final UserStore userStore = Modular.get();
  final ZipCodeStore zipCodeStore = ZipCodeStore();
  final LecuponService lecuponService = LecuponService();
  final PreferencesService _service = PreferencesService();
  final NewBeneficiaryModel data = NewBeneficiaryModel();

  String password = '';
  NewJwtModel? jwtModel;
  RegisterStore()
      : super(
          NewBeneficiaryModel(
            individualPerson: IndividualPersonModel(
              user: UserModel(),
              address: AddressModel(),
            ),
          ),
        );

  void updateForm(NewBeneficiaryModel form) {
    // update(NewBeneficiaryModel.oldFromJson(form.toJson()));
  }

  Future<void> verifyUser(Map<String, String> params) async {
    setLoading(true);
    await _repository.verifyUser(params).then((beneficiary) {
      update(
        beneficiary
          // ..termsAccepted = state.termsAccepted
          // ..programCode = beneficiary.programCode ?? state.programCode
          // ..responsible = beneficiary.responsible ?? state.responsible
          ..individualPerson = beneficiary.individualPerson ?? state.individualPerson,
      );
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
    setLoading(false);
  }

  Future<void> verifyPsp(String pspCode) async {
    setLoading(true);
    await _repository.verifyPsp(pspCode).then((validate) {
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
    setLoading(false);
  }

  bool isUnderage() {
    if (state.individualPerson?.birth != null) {
      final int ageInDays = DateTime.now()
          .difference(
            Formaters.stringToDate(
              state.individualPerson!.birth!,
              format: 'dd/MM/yyyy',
            ),
          )
          .inDays;

      return (ageInDays / 365.25) < 18;
    } else {
      return false;
    }
  }

  Future createUser() async {
    setLoading(true);
    // await Future.delayed(Duration(seconds: 2));
    await _repository
        .createUser(
      state.individualPerson!.name!,
      state.individualPerson!.user!.email!,
      state.individualPerson!.cpf!,
    )
        .catchError((onError) {
      setLoading(false);
      throw onError;
    });
    setLoading(false);
  }

  Future confirmUser(String id, String token, String password) async {
    setLoading(true);
    this.password = password;
    jwtModel = await _repository.confirmUserCreate(
      id,
      token,
      password,
    );
    setLoading(false);
  }

  Future resendConfirmUser(String email) async {
    try {
      setLoading(true);
      jwtModel = await _repository.resendUserConfirmation(email);
      setLoading(false);
    } on DioError catch (e) {
      setLoading(false);
      throw Exception(e.response?.data);
    }
  }

  Future updateUser({NewPreferencesModel? prefs, String? pass}) async {
    setLoading(true);
    IndividualPersonModel userData = IndividualPersonModel();
    if (prefs?.jwt != null) {
      jwtModel = prefs!.jwt;
    } else {
      userData = await _repository.fetchUserData(
        jwtModel!.token!,
        jwtModel!.id.toString(),
      );
    }
    if (prefs != null) {
      state.individualPerson!.name = prefs.user!.individualPerson!.name;
      state.individualPerson!.email = prefs.user!.individualPerson!.email;
      state.individualPerson!.cpf = prefs.user!.individualPerson!.cpf;
    } else {
      state.individualPerson!.email = userData.email;
      state.individualPerson!.cpf = userData.cpf;
      state.individualPerson!.name = userData.name;
    }

    return await _repository
        .updateUser(
      state,
      jwtModel!.token!,
      jwtModel!.id!,
    )
        .then((value) async {
      final NewPreferencesModel preferences = NewPreferencesModel();
      preferences.jwt = jwtModel;
      preferences.user = state;
      await _service.setUserPreferences(preferences);
      setLoading(false);
      // se for somente atualizar os dados, como quem já fez o login e
      // foi redirecionado, enviar para a tela inicial
      if (prefs != null) {
        Modular.to.pushReplacementNamed('/newHome');
      }
      return value;
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
  }

  Future<void> registerBeneficiary(NewBeneficiaryModel data) async {
    late BeneficiaryModel beneficiaryModel;
    setLoading(true);
    // await lecuponService.registerUser(beneficiary: data).catchError((onError) {
    //   setLoading(false);
    //   throw onError;
    // });
    await _repository.registerBeneficiary(data).then((beneficiary) async {
      beneficiaryModel = beneficiary;
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
  }

  bool isDisabled({required int page}) {
    try {
      switch (page) {
        case 0:
          final bool isDisable = (state.individualPerson!.birth == null || state.individualPerson!.birth!.isEmpty) ||
              (state.individualPerson!.cpf == null || state.individualPerson!.cpf!.isEmpty) ||
              (state.individualPerson!.name == null || state.individualPerson!.name!.isEmpty) ||
              (state.individualPerson!.phone == null || state.individualPerson!.phone!.isEmpty) ||
              state.individualPerson!.genre == null;
          return isDisable;
        case 1:
        // return state.programCode == null || state.programCode!.isEmpty;
        case 2:
          late final bool isUnderageValid;
          if (isUnderage()) {
            // if (state.responsible == null) {
            //   isUnderageValid = true;
            // } else {
            //   isUnderageValid = (state.responsible!.name == null || state.responsible!.name!.isEmpty) ||
            //       (state.responsible!.cpf == null || state.responsible!.cpf!.isEmpty) ||
            //       (state.responsible!.type == null);
            // }
          } else {
            isUnderageValid = false;
          }
          final bool isDisable = (state.individualPerson!.name == null || state.individualPerson!.name!.isEmpty) ||
              (state.individualPerson!.phone == null || state.individualPerson!.phone!.isEmpty) ||
              isUnderageValid;

          return isDisable;
        case 3:
          final bool isDisable = (state.individualPerson!.address!.zipCode == null ||
                  state.individualPerson!.address!.zipCode!.isEmpty) ||
              (state.individualPerson!.address!.city == null || state.individualPerson!.address!.city!.isEmpty) ||
              (state.individualPerson!.address!.state == null || state.individualPerson!.address!.state!.isEmpty) ||
              (state.individualPerson!.address!.street == null || state.individualPerson!.address!.street!.isEmpty) ||
              (state.individualPerson!.address!.district == null || state.individualPerson!.address!.district!.isEmpty);

          return isDisable;
        case 4:
          final bool isDisable =
              (state.individualPerson!.user!.username == null || state.individualPerson!.user!.username!.isEmpty) ||
                  (state.individualPerson!.user!.email == null || state.individualPerson!.user!.email!.isEmpty) ||
                  (state.individualPerson!.user!.password == null || state.individualPerson!.user!.password!.isEmpty)
              // ||
              // !state.termsAccepted
              ;
          return isDisable;

        default:
          return false;
      }
    } catch (e) {
      log('isDisabled: $e');
      return false;
    }
  }

  @override
  void dispose() {
    _repository.dispose();
    zipCodeStore.destroy();
  }
}
