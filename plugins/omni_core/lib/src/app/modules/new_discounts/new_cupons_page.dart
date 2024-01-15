import 'package:benefits_labels/labels.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/coupon_rescue_enum.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_rescue_type_filter_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/cupons_list_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/organizations_list_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/widgets/coupon_rescue_type_filter_widget.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/widgets/cupon_card_widget.dart';
import 'package:omni_core/src/app/modules/new_discounts/widgets/cupon_widget.dart';
import 'package:omni_core/src/app/modules/new_discounts/widgets/new_coupon_rescue_type_filter_widget.dart';
import 'package:omni_general/omni_general.dart';

class NewCuponsPage extends StatefulWidget {
  final int organizationId;
  final String? couponRescueType;
  final String moduleName;
  final String coverImage;
  final String categoryParam;
  const NewCuponsPage({
    Key? key,
    required this.organizationId,
    required this.moduleName,
    required this.coverImage,
    required this.categoryParam,
    this.couponRescueType,
  }) : super(key: key);

  @override
  State<NewCuponsPage> createState() => _NewCuponsPageState();
}

class _NewCuponsPageState extends State<NewCuponsPage> {
  final CuponsListStore store = CuponsListStore();
  final ScrollController scrollController = ScrollController();
  final CouponRescueTypeFilterStore couponRescueTypeFilterStore = Modular.get();
  final OrganizationsListStore organizationStore = Modular.get();
  @override
  void initState() {
    super.initState();
    // store.params.usageType = CouponRescueType.online.toJson;
    store.params.usageType = widget.couponRescueType;
    couponRescueTypeFilterStore.onChangeTypeWithoutRequest(
      CouponRescueType.physical.couponRescueTypeFromJson(widget.couponRescueType),
    );
    organizationStore
        .getPharmaOrganizationsList(
          categoryId: widget.categoryParam,
        )
        .then(
          (value) => organizationStore.getDiscountCategories(),
        );

    // store.getOrganizationCupons(organzationId: 19);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width > 500 ? 500 : 375;

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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20 * fem),
            child: const NewCouponRescueTypeFilterWidget(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16 * fem),
        child:
            // TripleBuilder<CuponsListStore, DioError, List<CupomModel>>(
            //   store: store,
            //   builder: (_, triple) {
            // if (triple.isLoading) {
            //   return const LoadingWidget();
            // }
            // return
            Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.moduleName,
              style: TextStyle(
                fontSize: 22 * fem,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 20 * fem,
            ),
            TextFieldWidget(
              label: 'Buscar...',
              controller: TextEditingController(),
              // focusNode: usernameFocus,
              focusedborder: InputBorder.none,
              padding: EdgeInsets.zero,
              textCapitalization: TextCapitalization.none,
              fem: fem,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black54,
                size: 24 * fem,
              ),
              onChange: (String? input) {
                // store.state.username = input;
                // store.updateForm(store.state);
              },
            ),
            SizedBox(
              height: 10 * fem,
            ),
            TripleBuilder<OrganizationsListStore, DioError, List<OrganizationModel>>(
                store: organizationStore,
                builder: (_, triple) {
                  if (triple.isLoading) {
                    return SizedBox(
                      height: 450 * fem,
                      child: Center(
                        child: LoadingWidget(),
                      ),
                    );
                  }
                  if (triple.event == TripleEvent.error) {
                    return Center(
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
                    );
                  }
                  if (!triple.isLoading && triple.state.isEmpty) {
                    return Center(
                      child: SingleChildScrollView(
                        clipBehavior: Clip.antiAlias,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        physics: const BouncingScrollPhysics(),
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
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: organizationStore.state.length,
                    itemBuilder: (context, index) {
                      final discount = organizationStore.state[index];
                      return CuponWidget(
                        organization: discount,
                        couponRescueType: couponRescueTypeFilterStore.state,
                      );
                    },
                  );
                }),
          ],
        ),
        // ;

        // return RefreshIndicator(
        //   onRefresh: () async {
        //     await store.getOrganizationCupons(
        //       organzationId: widget.organizationId,
        //     );
        //   },
        //   child: ListView.separated(
        //     physics: const AlwaysScrollableScrollPhysics(),
        //     separatorBuilder: (context, index) => const SizedBox(height: 20),
        //     shrinkWrap: true,
        //     itemCount: store.state.length > 3 ? 3 : store.state.length,
        //     itemBuilder: (_, index) {
        //       store.state[index].organizationId = widget.organizationId;

        //       return CuponCardWidget(
        //         model: store.state[index],
        //         coverImage: widget.coverImage,
        //       );
        //     },
        //   ),
        // );
        //   },
        // ),
      ),
    );
  }
}
