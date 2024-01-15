import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/core/enums/coupon_rescue_enum.dart';
import 'package:omni_general/omni_general.dart';

import '../../../core/resources/assets.dart';

class CuponWidget extends StatelessWidget {
  const CuponWidget({
    Key? key,
    required this.organization,
    required this.couponRescueType,
  }) : super(key: key);
  final CouponRescueType couponRescueType;
  final OrganizationModel organization;
  @override
  Widget build(BuildContext context) {
    double baseWidth = MediaQuery.of(context).size.width > 500 ? 500 : 375;

    double fem = MediaQuery.of(context).size.width / baseWidth;
    return InkWell(
      onTap: () => Modular.to.pushNamed(
        '/newHome/discounts/discount_details',
        arguments: {
          'organizationId': organization.id,
          'couponRescueType': couponRescueType,
        },
      ),
      child: Container(
        padding: EdgeInsets.all(8 * fem),
        margin: EdgeInsets.only(bottom: 10 * fem),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffededf1)),
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0f1f2023),
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              // rectangle36mQ3 (I4902:29248;4902:25943)
              margin: const EdgeInsets.fromLTRB(0, 0, 16, 0),
              width: 80 * fem,
              height: 80 * fem,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  organization.coverPicture!,
                  width: 60 * fem,
                  height: 60 * fem,
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // drograriasopauloPgK (I4902:29248;2631:17573)

                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      organization.name!,
                      style: TextStyle(
                        fontSize: 16 * fem,
                        fontWeight: FontWeight.w500,
                        height: 1.6000000238,
                        color: Color(0xff1a1c22),
                      ),
                    ),
                  ),
                  SizedBox(
                    // width: double.maxFinite,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          // statusgfR (I4902:29248;4902:25317)
                          padding: EdgeInsets.symmetric(
                            vertical: 4 * fem,
                            horizontal: 12 * fem,
                          ),
                          decoration: BoxDecoration(
                            color: Helpers.getBackgroundColor(
                              organization.bestDiscountPercent!,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Text(
                              'Até ${organization.bestDiscountPercent}% off',
                              style: TextStyle(
                                fontSize: 14 * fem,
                                fontWeight: FontWeight.w500,
                                height: 1.4000000272,
                                color: Helpers.getTextColor(
                                  organization.bestDiscountPercent!,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // statusxsq (I4902:29248;4902:23631)

                          padding: EdgeInsets.symmetric(
                            vertical: 4 * fem,
                            horizontal: 12 * fem,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xfff6f6f8),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Text(
                              couponRescueType.label,
                              style: TextStyle(
                                fontSize: 14 * fem,
                                fontWeight: FontWeight.w500,
                                height: 1.4000000272,
                                color: Color(0xff878da0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
