import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_details_store.dart';
import 'package:omni_core/src/app/modules/new_discounts/widgets/cupon_description_dialog.dart';
import 'package:omni_general/omni_general.dart';

class DiscountDetailItem extends StatefulWidget {
  const DiscountDetailItem({Key? key, required this.cupom, this.title}) : super(key: key);
  final CupomModel cupom;
  final String? title;
  @override
  State<DiscountDetailItem> createState() => _DiscountDetailItemState();
}

class _DiscountDetailItemState extends State<DiscountDetailItem> {
  @override
  void initState() {
    super.initState();
    store.getCouponDetails(
      organizationId: widget.cupom.organizationId!,
      couponId: widget.cupom.id ?? 0,
    );
  }

  final CouponDetailsStore store = CouponDetailsStore();
  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width > 500 ? 500 : 375;

    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return DottedBorder(
      borderType: BorderType.RRect,
      dashPattern: [4, 4],
      radius: Radius.circular(20),
      color: Helpers.getTextColor(widget.cupom.discount!),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8 * fem),
          color: Helpers.getBackgroundColor(widget.cupom.discount!),
        ),
        child: Column(
          children: [
            Text(
              widget.title ?? 'Até ${widget.cupom.discount}% off',
              style: TextStyle(
                fontSize: 22 * ffem,
                fontWeight: FontWeight.w600,
                height: 1.2999999306 * ffem / fem,
                color: Helpers.getTextColor(widget.cupom.discount!),
              ),
            ),
            const SizedBox(height: 8),
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
            const SizedBox(height: 8),
            if (widget.cupom.organizationId != 0)
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
                child: Text(
                  'Resgatar cupom',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14 * ffem,
                    fontWeight: FontWeight.w700,
                    height: 1.7142857143 * ffem / fem,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
          ],
        ),
      ),
      // ),
    );
  }
}
