import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_details_store.dart';
import 'package:omni_general/omni_general.dart';

class RescueCouponStore extends NotifierStore<DioError, String> {
  RescueCouponStore() : super('');

  final LecuponService lecuponService = LecuponService();
  final CouponDetailsStore store = Modular.get();

  Future<void> rescueCoupon({
    required int organizationId,
    required RescueCouponModel rescueCoupon,
  }) async {
    setLoading(true);
    await lecuponService
        .rescueCoupon(
      organizationId: organizationId,
      rescueCoupon: rescueCoupon,
    )
        .then((value) {
      store.state.code = value;
      store.update(store.state, force: true);
      update(value);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
      throw onError;
    });
  }
}
