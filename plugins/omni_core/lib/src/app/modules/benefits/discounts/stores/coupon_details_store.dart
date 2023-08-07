import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';

class CouponDetailsStore extends NotifierStore<DioError, CupomModel> {
  CouponDetailsStore() : super(CupomModel());

  final LecuponService lecuponService = LecuponService();

  Future<void> getCouponDetails({
    required int organizationId,
    required int couponId,
  }) async {
    setLoading(true);
    await lecuponService
        .getCupomById(
      organizationId: organizationId,
      couponId: couponId,
    )
        .then((coupon) {
      update(coupon);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      log(onError.toString());
      setError(onError);
    });
  }
}
