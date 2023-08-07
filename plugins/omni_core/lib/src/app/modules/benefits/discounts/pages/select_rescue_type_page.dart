import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/core/enums/coupon_rescue_enum.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_rescue_type_filter_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/organizations_list_store.dart';
import 'package:omni_general/omni_general.dart';

class SelectRecueTypePage extends StatefulWidget {
  final String? moduleName;
  final String? categoryParam;

  const SelectRecueTypePage({
    Key? key,
    this.moduleName,
    this.categoryParam,
  }) : super(key: key);

  @override
  State<SelectRecueTypePage> createState() => _SelectRecueTypePageState();
}

class _SelectRecueTypePageState extends State<SelectRecueTypePage> {
  final OrganizationsListStore store = Modular.get();
  final CouponRescueTypeFilterStore couponRescueTypeFilterStore = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(
        title: widget.moduleName!,
      ).build(context) as AppBar,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Selecione tipo de resgate',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'Para facilitar a navegação, escolha o modo de regaste de seus benefícios',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DefaultButtonWidget(
                    onPressed: () {
                      store.params.usageType = CouponRescueType.physical.toJson;
                      couponRescueTypeFilterStore.onChangeTypeWithoutRequest(
                        CouponRescueType.physical,
                      );
                      Modular.to.pushNamed(
                        'discounts',
                        arguments: {
                          'moduleName': widget.moduleName,
                          'categoryParam': widget.categoryParam,
                        },
                      );
                    },
                    text: 'Presencial',
                    buttonType: DefaultButtonType.outline,
                  ),
                  const SizedBox(width: 10),
                  DefaultButtonWidget(
                    onPressed: () {
                      store.params.usageType = CouponRescueType.online.toJson;
                      couponRescueTypeFilterStore
                          .onChangeTypeWithoutRequest(CouponRescueType.online);
                      Modular.to.pushNamed(
                        'discounts',
                        arguments: {
                          'moduleName': widget.moduleName,
                          'categoryParam': widget.categoryParam,
                        },
                      );
                    },
                    text: 'Online',
                    buttonType: DefaultButtonType.outline,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
