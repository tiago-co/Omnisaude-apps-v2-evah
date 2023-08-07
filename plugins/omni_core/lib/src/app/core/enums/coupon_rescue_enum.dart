enum CouponRescueType { online, physical }

extension CouponRescueTypeExtension on CouponRescueType {
  String get label {
    switch (this) {
      case CouponRescueType.online:
        return 'Online';
      case CouponRescueType.physical:
        return 'Presencial';
    }
  }

  String? get toJson {
    switch (this) {
      case CouponRescueType.online:
        return 'online';
      case CouponRescueType.physical:
        return 'physical';
      default:
        return null;
    }
  }

  CouponRescueType? couponRescueTypeFromJson(String? type) {
    switch (type) {
      case 'physical':
        return CouponRescueType.physical;
      case 'online':
        return CouponRescueType.online;
      default:
        return null;
    }
  }
}
