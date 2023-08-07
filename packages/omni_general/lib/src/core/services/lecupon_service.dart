import 'dart:developer';

import 'package:omni_general/omni_general.dart';

class LecuponService {
  static final _lecuponRepository = LecuponRepository();
  late ActivateUserModel activateUser;
  late LecuponUserModel lecuponUser;

  Future<LecuponUserModel> registerUser({
    required NewBeneficiaryModel beneficiary,
  }) async {
    await _lecuponRepository.getAdmminToken();
    await _lecuponRepository
        .createAuthorizedUser(
          activeUser: ActivateUserModel(
            name: beneficiary.individualPerson?.name,
            cpf: beneficiary.individualPerson?.cpf,
            email: beneficiary.individualPerson?.user?.email,
            phone: beneficiary.individualPerson?.phone,
            active: true,
          ),
        )
        .then((value) => activateUser = value);
    await _lecuponRepository
        .registerUser(activateUser: activateUser)
        .then((value) => lecuponUser = value);

    activateUser.cpf = beneficiary.individualPerson?.cpf;

    return lecuponUser;
  }

  Future<List<DiscountCategoryModel>> getDiscountsCategories({
    required BeneficiaryModel beneficiary,
    required CupomParamsModel params,
  }) async {
    List<DiscountCategoryModel> listDiscountCategories = [];
    await _lecuponRepository
        .getDiscountsCategories(
          beneficiary: beneficiary,
          params: params,
        )
        .then((value) => listDiscountCategories = value);

    return listDiscountCategories;
  }

  Future<List<OrganizationModel>> getOrganizationsList({
    required BeneficiaryModel beneficiary,
    required CupomParamsModel params,
  }) async {
    return _lecuponRepository.getOrganizationsList(
      beneficiary: beneficiary,
      params: params,
    );
  }

  Future<List<CupomModel>> getOrganizationCupons({
    required int organizationUid,
    required CupomParamsModel params,
  }) async {
    return _lecuponRepository.getOrganizationCupons(
      organizationUid: organizationUid,
      params: params,
    );
  }

  Future<LecuponUserModel?> lecuponAuthenticate({
    required BeneficiaryModel beneficiary,
  }) async {
    late String smartLinkToken;

    try {
      await _lecuponRepository.getAdmminToken();
    } catch (e) {
      log(e.toString());
    }

    await _lecuponRepository
        .getSmartlinkAuthenticationToken(
          cpf: beneficiary.individualPerson!.cpf!,
        )
        .then((value) => smartLinkToken = value)
        .catchError(
      (onError) {
        log(onError.toString());
      },
    );
    await _lecuponRepository
        .smartLinkAuthenticate(smartToken: smartLinkToken)
        .then(
      (value) {
        lecuponUser = value;
      },
    ).catchError((onError) {
      log(onError.toString());
    });

    return lecuponUser;
  }

  Future<CupomModel> getCupomById({
    required int organizationId,
    required int couponId,
  }) async {
    return _lecuponRepository.getCupomById(
      organizationId: organizationId,
      couponId: couponId,
    );
  }

  Future<String> rescueCoupon({
    required int organizationId,
    required RescueCouponModel rescueCoupon,
  }) async {
    return _lecuponRepository.rescueCoupon(
      organizationId: organizationId,
      rescueCoupon: rescueCoupon,
    );
  }
}
