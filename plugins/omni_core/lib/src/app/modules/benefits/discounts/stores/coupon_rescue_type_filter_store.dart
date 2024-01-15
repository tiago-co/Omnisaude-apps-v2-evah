import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/coupon_rescue_enum.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/organizations_list_store.dart';

class CouponRescueTypeFilterStore extends NotifierStore<Exception, CouponRescueType> {
  CouponRescueTypeFilterStore() : super(CouponRescueType.physical);

  final OrganizationsListStore organizationsListStore = Modular.get();

  Future<void> onChangeType(CouponRescueType? type) async {
    update(type!);
    organizationsListStore.params.organizationType = type.toJson;
    organizationsListStore.params.usageType = type.toJson;
    organizationsListStore.getPharmaOrganizationsList(
      categoryId: organizationsListStore.params.categoryId,
    );
  }

  Future<void> onChangeTypeWithoutRequest(CouponRescueType? type) async {
    update(type!);
    organizationsListStore.params.usageType = type.toJson;
    organizationsListStore.params.organizationType = type.toJson;
  }
}
