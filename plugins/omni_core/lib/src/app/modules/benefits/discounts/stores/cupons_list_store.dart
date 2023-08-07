import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';

class CuponsListStore extends NotifierStore<DioError, List<CupomModel>> {
  CuponsListStore() : super([]);

  final UserStore userStore = Modular.get();
  final LecuponService lecuponService = LecuponService();
  final GeolocatorService geolocatorService = GeolocatorService();

  final CupomParamsModel params = CupomParamsModel();

  Future<void> getOrganizationCupons({
    required int organzationId,
  }) async {
    setLoading(true);
    final userPosition = await geolocatorService.getUserPosition();

    params.lat = userPosition.latitude.toString();
    params.lng = userPosition.longitude.toString();
    await lecuponService
        .getOrganizationCupons(
      organizationUid: organzationId,
      params: params,
    )
        .then((cupons) {
      update(cupons);
      setLoading(false);
    });
  }
}
