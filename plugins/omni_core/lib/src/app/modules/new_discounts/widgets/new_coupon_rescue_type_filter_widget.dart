import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/core/enums/coupon_rescue_enum.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_rescue_type_filter_store.dart';
import 'package:omni_general/omni_general.dart';

class NewCouponRescueTypeFilterWidget extends StatefulWidget {
  const NewCouponRescueTypeFilterWidget({Key? key}) : super(key: key);

  @override
  State<NewCouponRescueTypeFilterWidget> createState() => _NewCouponRescueTypeFilterWidgetState();
}

class _NewCouponRescueTypeFilterWidgetState extends State<NewCouponRescueTypeFilterWidget> {
  final CouponRescueTypeFilterStore store = Modular.get();
  double baseWidth = 500;
  double fem = 0.0;
  @override
  Widget build(BuildContext context) {
    baseWidth = MediaQuery.of(context).size.width > 500 ? 500 : 375;
    fem = MediaQuery.of(context).size.width / baseWidth;
    return TripleBuilder<CouponRescueTypeFilterStore, Exception, CouponRescueType>(
      store: store,
      builder: (_, triple) {
        return InkWell(
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              enableDrag: true,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              builder: (_) => _buildStatusSheetWidget(_),
            );
          },
          borderRadius: BorderRadius.circular(10),
          highlightColor: Colors.transparent,
          splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
          child: Row(
            children: [
              Text(
                triple.state.label,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14 * fem,
                    ),
              ),
              SizedBox(width: 4 * fem),
              Icon(
                Icons.tune,
                color: Colors.black54,
                size: 24 * fem,
              ),
            ],
          ),
          // TripleBuilder<CouponRescueTypeFilterStore, Exception, CouponRescueType>(
          //   store: store,
          //   builder: (_, triple) {
          //     return Container(
          //       decoration: BoxDecoration(
          //         // color: Theme.of(context).primaryColor,
          //         border: Border.all(
          //           color: Theme.of(context).primaryColor,
          //           width: 0.5,
          //         ),
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          //       child:
          //       Row(
          //         children: [
          //           SvgPicture.asset(
          //             Assets.filter,
          //             package: AssetsPackage.omniGeneral,
          //             width: 15,
          //             height: 15,
          //             color: Colors.white,
          //           ),
          //           const SizedBox(width: 10),
          //           Text(
          //             triple.state.label,
          //             style: Theme.of(context).textTheme.titleLarge!.copyWith(
          //                   color: Colors.white,
          //                 ),
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
        );
      },
    );
  }

  Widget _buildStatusSheetWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      margin: const EdgeInsets.only(top: 60),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15 * fem,
            vertical: 10 * fem,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 30 * fem,
                height: 2.5 * fem,
                decoration: BoxDecoration(color: Colors.grey.shade300),
              ),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemCount: CouponRescueType.values.length,
                  itemBuilder: (_, index) {
                    return _buildRadioItemWidget(
                      CouponRescueType.values[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioItemWidget(CouponRescueType status) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: () async {
          store.onChangeType(status);
          Modular.to.pop();
        },
        dense: true,
        contentPadding: EdgeInsets.zero,
        title: Text(
          status.label,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 14 * fem,
              ),
        ),
      ),
    );
  }
}
