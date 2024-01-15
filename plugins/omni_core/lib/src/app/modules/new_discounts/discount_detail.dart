import 'package:benefits_labels/labels.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/coupon_rescue_enum.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/cupons_list_store.dart';
import 'package:omni_core/src/app/modules/new_discounts/widgets/cupon_description_dialog.dart';
import 'package:omni_core/src/app/modules/new_discounts/widgets/discount_detail_item.dart';
import 'package:omni_general/omni_general.dart';

class DiscountDetail extends StatefulWidget {
  const DiscountDetail({
    required this.organizationId,
    required this.couponRescueType,
    Key? key,
  }) : super(key: key);
  final int organizationId;
  final CouponRescueType couponRescueType;
  @override
  State<DiscountDetail> createState() => _DiscountDetailState();
}

class _DiscountDetailState extends State<DiscountDetail> {
  final CuponsListStore store = CuponsListStore();

  @override
  void initState() {
    super.initState();
    store.params.usageType = widget.couponRescueType.toJson;
    // store.params.usageType = CouponRescueType.physical.toJson;
    store.getOrganizationCupons(organzationId: widget.organizationId);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 500;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20 * fem),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selecione um desconto',
              style: TextStyle(
                fontSize: 22 * fem,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20 * fem,
            ),
            TripleBuilder<CuponsListStore, DioError, List<CupomModel>>(
              store: store,
              builder: (_, triple) {
                if (triple.isLoading) {
                  return const Center(child: LoadingWidget());
                }
                if (triple.event == TripleEvent.error) {
                  return Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            clipBehavior: Clip.antiAlias,
                            physics: const BouncingScrollPhysics(),
                            child: RequestErrorWidget(
                              error: triple.error,
                              onPressed: () => store.getOrganizationCupons(
                                organzationId: widget.organizationId,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                if (!triple.isLoading && triple.state.isEmpty) {
                  return SizedBox(
                    height: 450,
                    child: Center(
                      child: EmptyWidget(
                        message: BenefitsLabels.cuponsEmpty,
                        textButton: BenefitsLabels.tryAgain,
                        onPressed: () => store.getOrganizationCupons(
                          organzationId: widget.organizationId,
                        ),
                      ),
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    await store.getOrganizationCupons(
                      organzationId: widget.organizationId,
                    );
                  },
                  child: ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(height: 20),
                    shrinkWrap: true,
                    itemCount: store.state.length > 3 ? 3 : store.state.length,
                    itemBuilder: (_, index) {
                      store.state[index].organizationId = widget.organizationId;
                      final cupomModel = store.state[index];
                      return DiscountDetailItem(cupom: cupomModel);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
