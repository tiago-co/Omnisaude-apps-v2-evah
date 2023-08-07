class RescueCouponModel {
  int? couponId;
  String? confirmationKey;

  RescueCouponModel({this.couponId, this.confirmationKey});

  RescueCouponModel.fromJson(Map<String, dynamic> json) {
    couponId = json['coupon_id'];
    confirmationKey = json['confirmation_key'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['coupon_id'] = couponId;
    data['confirmation_key'] = confirmationKey;

    return data;
  }
}
