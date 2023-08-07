import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';

class OrganizationsListStore
    extends NotifierStore<DioError, List<OrganizationModel>> {
  OrganizationsListStore() : super([]);

  final UserStore userStore = Modular.get();
  final LecuponService lecuponService = LecuponService();
  final GeolocatorService geolocatorService = GeolocatorService();
  final CupomParamsModel params = CupomParamsModel();
  List<DiscountCategoryModel> listDiscountCategories = [];
  Timer? _debounce;

  Future<void> getDiscountCategories() async {
    setLoading(true);
    final userPosition = await geolocatorService.getUserPosition();

    params.lat = userPosition.latitude.toString();
    params.lng = userPosition.longitude.toString();
    await lecuponService
        .getDiscountsCategories(
          beneficiary: userStore.beneficiary,
          params: params,
        )
        .then((value) => listDiscountCategories = value)
        .catchError((onError) {
      setError(onError);
      setLoading(false);
    });

    setLoading(false);
  }

  Future<void> getOrganizationCupons({required int organizationUid}) async {
    final userPosition = await geolocatorService.getUserPosition();

    params.organizationType = 'physical';
    params.lat = userPosition.latitude.toString();
    params.lng = userPosition.longitude.toString();
    await lecuponService.getOrganizationCupons(
      organizationUid: organizationUid,
      params: params,
    );
  }

  Future<void> getPharmaOrganizationsList({String? categoryId}) async {
    setLoading(true);
    final userPosition = await geolocatorService.getUserPosition();

    params.categoryId = categoryId;
    params.lat = userPosition.latitude.toString();
    params.lng = userPosition.longitude.toString();

    await lecuponService
        .getOrganizationsList(
      beneficiary: userStore.beneficiary,
      params: params,
    )
        .then((organizationsList) {
      update(organizationsList);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  Future<void> getOrganizationsListSearch(
    String? search,
  ) async {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      params.search = search;
      await lecuponService
          .getOrganizationsList(
        beneficiary: userStore.beneficiary,
        params: params,
      )
          .then((organizationsList) {
        update(organizationsList);
      }).catchError((onError) {
        setError(onError);
      });
    });
  }
}
