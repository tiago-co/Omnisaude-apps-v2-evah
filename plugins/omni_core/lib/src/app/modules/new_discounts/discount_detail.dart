import 'package:benefits_labels/labels.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/core/enums/coupon_rescue_enum.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/cupons_list_store.dart';
import 'package:omni_core/src/app/modules/new_discounts/widgets/cupon_description_dialog.dart';
import 'package:omni_core/src/app/modules/new_discounts/widgets/discount_detail_item.dart';
import 'package:omni_general/omni_general.dart';

class DiscountDetail extends StatefulWidget {
  const DiscountDetail({
    required this.organizationId,
    required this.couponRescueType,
    this.organization,
    Key? key,
  }) : super(key: key);
  final int organizationId;
  final CouponRescueType couponRescueType;
  final OrganizationModel? organization;

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
        title: Text(
          '${widget.organization?.name}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await store.getOrganizationCupons(
            organzationId: widget.organizationId,
          );
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 20),
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 120,
                    height: 120,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.network(
                      widget.organization!.coverPicture.toString(),
                      fit: BoxFit.fitHeight,
                      loadingBuilder: (
                        context,
                        child,
                        loadingProgress,
                      ) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const CircularProgressIndicator.adaptive();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return ImageWidget(
                          url: '',
                          asset: Assets.test,
                          width: 60,
                          height: 60,
                          package: AssetsPackage.omniGeneral,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Selecione um desconto',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TripleBuilder<CuponsListStore, DioError, List<CupomModel>>(
                  store: store,
                  builder: (_, triple) {
                    if (triple.isLoading) {
                      return const SizedBox(
                        height: 250,
                        child: Center(
                          child: LoadingWidget(),
                        ),
                      );
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
                    return ListView.separated(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) => const SizedBox(height: 20),
                      itemCount: store.state.length > 3 ? 3 : store.state.length,
                      itemBuilder: (_, index) {
                        store.state[index].organizationId = widget.organizationId;
                        final cupomModel = store.state[index];
                        return DiscountDetailItem(cupom: cupomModel);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
