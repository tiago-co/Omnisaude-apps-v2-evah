import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';

class ProfileStore extends NotifierStore<DioError, IndividualPersonModel> with Disposable {
  final BeneficiaryRepository _repository = Modular.get();
  final UserStore userStore = Modular.get();
  final ZipCodeStore zipCodeStore = Modular.get();

  ProfileStore() : super(IndividualPersonModel());

  void updateProfile(IndividualPersonModel individualPerson) {
    update(individualPerson);
  }

  Future<void> updateAddressByCep(
    Map<String, dynamic> data,
    Function updateAddressFields,
  ) async {
    setLoading(true);
    zipCodeStore
        .getAddressByCep(
      data['cep'].toString().replaceAll(RegExp(r'[^0-9]'), ''),
    )
        .then(
      (address) {
        updateAddressFields(address);
        updateField(
          {
            'endereco': {
              'cidade': address.city,
              'bairro': address.district ?? '',
              'uf': address.uf,
              'cep': address.zipCode,
              'logradouro': address.street ?? '',
              'complemento': address.complement ?? '',
            },
          },
        );
        setLoading(false);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        throw onError;
      },
    );
  }

  Future<void> updateNewProfile() async {
    setLoading(true);
    await _repository
        .updateProfile(
      state,
      userStore.userId,
    )
        .then((individualPerson) async {
      individualPerson = await _repository.getIndividualPerson(userStore.userId);
      userStore.beneficiary.individualPerson = individualPerson;
      userStore.state.beneficiary = userStore.beneficiary;
      userStore.setUserPreferences(
        PreferencesModel.fromJson(userStore.state.toJson()),
        userStore.userId,
      );
      userStore.update(PreferencesModel.fromJson(userStore.state.toJson()));
      update(IndividualPersonModel.fromJson(individualPerson.toJson()));
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
  }

  Future<void> updateField(Map<String, dynamic> data) async {
    setLoading(true);
    // userStore.state.beneficiary!.individualPerson!.image = null;
    // userStore.update(PreferencesModel.fromJson(userStore.state.toJson()));
    await _repository
        .updateIndividualPerson(
      data,
      userStore.userId,
    )
        .then((individualPerson) {
      userStore.beneficiary.individualPerson = individualPerson;
      userStore.state.beneficiary = userStore.beneficiary;
      userStore.setUserPreferences(
        PreferencesModel.fromJson(userStore.state.toJson()),
        userStore.userId,
      );
      // userStore.update(PreferencesModel.fromJson(userStore.state.toJson()));
      update(IndividualPersonModel.fromJson(individualPerson.toJson()));
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
  }

  Future<void> getIndividualPerson() async {
    setLoading(true);
    await _repository.getIndividualPerson(userStore.userId).then((individualPerson) {
      update(individualPerson);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      throw onError;
    });
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
