import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/enums/coupon_rescue_enum.dart';
import 'package:omni_core/src/app/core/enums/coupon_template_enum.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_details_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_rescue_type_filter_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/rescue_coupon_store.dart';
import 'package:omni_general/omni_general.dart';

class CuponDescriptionDialog extends StatefulWidget {
  const CuponDescriptionDialog({Key? key, required this.organizationId, required this.store}) : super(key: key);
  final int? organizationId;
  final CouponDetailsStore store;
  @override
  State<CuponDescriptionDialog> createState() => _CuponDescriptionDialogState();
}

class _CuponDescriptionDialogState extends State<CuponDescriptionDialog> {
  late final CouponDetailsStore store;
  final RescueCouponStore rescueCouponStore = Modular.get();
  final CouponRescueTypeFilterStore couponRescueTypeFilterStore = Modular.get();

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
        if (triple.isLoading && (couponRescueTypeFilterStore.state == CouponRescueType.physical)) {
          return const SizedBox();
        }

        return Visibility(
          visible: store.state.code != null,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: FloatingActionButton.extended(
                onPressed: () {
                  store.state.template!.getOnTapFloatingButton(context, store);
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
          ),
        );
      },
    );
  }

  @override
  void initState() {
    store = widget.store;
    super.initState();
    if (couponRescueTypeFilterStore.state == CouponRescueType.physical) {
      rescueCouponStore
          .rescueCoupon(
            // organizationId: store.state.organizationId!,
            organizationId: widget.organizationId!,
            rescueCoupon: RescueCouponModel(
              couponId: store.state.id,
            ),
          )
          .then(
            (value) => setState(() {
              store.state.code = value;
            }),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => Modular.to.pop(),
                    icon: const Icon(
                      Icons.close,
                      color: Colors.black54,
                    ),
                  ),
                ),
                buildDescription,
                const SizedBox(height: 10),
                buildRules,
                if (couponRescueTypeFilterStore.state == CouponRescueType.physical)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      buildCouponCode,
                    ],
                  ),
                const SizedBox(height: 55),
                buildRescue,
                // Text(
                //   store.state.description!,
                //   textAlign: TextAlign.center,
                //   style: Theme.of(context).textTheme.displaySmall!.copyWith(
                //         fontSize: 14,
                //       ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
