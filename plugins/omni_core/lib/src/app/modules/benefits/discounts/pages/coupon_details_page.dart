import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/core/enums/coupon_rescue_enum.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_details_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_rescue_type_filter_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/rescue_coupon_store.dart';
import 'package:omni_general/omni_general.dart';

class CouponDetailsPage extends StatefulWidget {
  final String title;
  const CouponDetailsPage({Key? key, required this.title}) : super(key: key);

  @override
  State<CouponDetailsPage> createState() => _CouponDetailsPageState();
}

class _CouponDetailsPageState extends State<CouponDetailsPage> {
  final CouponDetailsStore store = Modular.get();
  final RescueCouponStore rescueCouponStore = Modular.get();
  final CouponRescueTypeFilterStore couponRescueTypeFilterStore = Modular.get();

  @override
  void initState() {
    super.initState();
    if (couponRescueTypeFilterStore.state == CouponRescueType.physical) {
      rescueCouponStore.rescueCoupon(
        organizationId: store.state.organizationId!,
        rescueCoupon: RescueCouponModel(
          couponId: store.state.id,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.title).build(context) as AppBar,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
          ),
          padding: const EdgeInsets.all(10),
          child: TripleBuilder<RescueCouponStore, DioError, String>(
            store: rescueCouponStore,
            builder: (_, triple) {
              if (triple.isLoading &&
                  (couponRescueTypeFilterStore.state ==
                      CouponRescueType.physical)) {
                return const LoadingWidget();
              }
              return ColoredBox(
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildDescription,
                      const SizedBox(height: 10),
                      buildRules,
                      if (couponRescueTypeFilterStore.state ==
                          CouponRescueType.physical)
                        Column(
                          children: [
                            const SizedBox(height: 10),
                            buildCouponCode,
                          ],
                        ),
                      const SizedBox(height: 55),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: buildRescue,
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }

  Widget get buildDescription {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Descrição da Promoção',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          store.state.description.toString(),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 14,
              ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget get buildRules {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Regras da Promoção',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          store.state.rules.toString(),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 14,
              ),
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

  Widget get buildCouponCode {
    return Visibility(
      visible: store.state.code != null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Código',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Align(
            child: Text(
              store.state.code.toString(),
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    letterSpacing: 2,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget get buildRescue {
    return TripleBuilder<RescueCouponStore, DioError, String>(
      store: rescueCouponStore,
      builder: (_, triple) {
        if (triple.isLoading &&
            (couponRescueTypeFilterStore.state == CouponRescueType.physical)) {
          return const SizedBox();
        }

        return Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: FloatingActionButton.extended(
              onPressed: () {
                store.state.template!.getOnTapFloatingButton(context);
              },
              label: triple.isLoading
                  ? const CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    )
                  : Text(
                      store.state.template!.buttonLabel,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        );
      },
    );
  }
}
