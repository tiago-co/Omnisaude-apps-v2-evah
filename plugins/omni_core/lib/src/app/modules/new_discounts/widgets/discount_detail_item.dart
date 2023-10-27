import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/new_discounts/widgets/cupon_description_dialog.dart';
import 'package:omni_general/omni_general.dart';

import '../../benefits/discounts/stores/coupon_details_store.dart';

class DiscountDetailItem extends StatefulWidget {
  const DiscountDetailItem({Key? key, required this.cupom}) : super(key: key);
  final CupomModel cupom;
  @override
  State<DiscountDetailItem> createState() => _DiscountDetailItemState();
}

class _DiscountDetailItemState extends State<DiscountDetailItem> {
  @override
  void initState() {
    super.initState();
    store.getCouponDetails(
      organizationId: widget.cupom.organizationId!,
      couponId: widget.cupom.id!,
    );
  }

  final CouponDetailsStore store = CouponDetailsStore();
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(vertical: 26),
      decoration: BoxDecoration(
        border: Border.all(
          color: Helpers.getTextColor(widget.cupom.discount!),
        ),
        borderRadius: BorderRadius.circular(12 * fem),
        color: Helpers.getBackgroundColor(widget.cupom.discount!),
      ),
      child: Column(
        children: [
          // Positioned(
          //   // rectangle8Jfy (2635:18069)
          //   left: 10 * fem,
          //   top: 10 * fem,
          //   child: Align(
          Text(
            'Até ${widget.cupom.discount}% off',
            style: TextStyle(
              fontSize: 22 * ffem,
              fontWeight: FontWeight.w600,
              height: 1.2999999306 * ffem / fem,
              color: Helpers.getTextColor(widget.cupom.discount!),
            ),
          ),

          Text(
            'Valido até ${Formaters.dateToStringDate(
              Formaters.stringToDate(widget.cupom.endDate!),
            )}',
            style: TextStyle(
              fontSize: 14 * ffem,
              fontWeight: FontWeight.w400,
              height: 1.4000000272 * ffem / fem,
              color: const Color(0xff52576a),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => CuponDescriptionDialog(
                  store: store,
                  organizationId: widget.cupom.organizationId,
                ),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
            ),
            child: Container(
              width: 119 * fem,
              height: 32 * fem,
              child: Container(
                // masterbuttonmasterjPu (I2635:18083;1106:10392)
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Helpers.getTextColor(widget.cupom.discount!),
                  borderRadius: BorderRadius.circular(60 * fem),
                ),
                child: Center(
                  child: Center(
                    child: Text(
                      'Resgatar',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.7142857143 * ffem / fem,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
