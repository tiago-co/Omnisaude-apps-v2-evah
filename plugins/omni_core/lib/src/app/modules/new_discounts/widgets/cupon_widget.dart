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
    this.categoryParam,
  }) : super(key: key);
  final CouponRescueType couponRescueType;
  final OrganizationModel organization;
  final String? categoryParam;
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
          'organization': organization,
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
                  width: 80 * fem,
                  height: 80 * fem,
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
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                  if (organization.address != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child: Text(
                        organization.address.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff696969),
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 15),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Helpers.getBackgroundColor(
                              organization.bestDiscountPercent!,
                            ),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: Center(
                            child: Text(
                              'Até ${organization.bestDiscountPercent}% de desconto',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.4000000272,
                                color: Helpers.getTextColor(
                                  organization.bestDiscountPercent!,
                                ),
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
