import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';

import '../../../core/resources/assets.dart';

class CuponWidget extends StatelessWidget {
  const CuponWidget({Key? key, required this.organization}) : super(key: key);

  final OrganizationModel organization;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Modular.to.pushNamed(
        '/newHome/discounts/discount_details',
        arguments: {
          'organizationId': organization.id,
        },
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.only(bottom: 10),
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
              width: 80,
              height: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  organization.coverPicture!,
                  width: 60,
                  height: 60,
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
                      style: const TextStyle(
                        fontSize: 16,
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
                              'Até ${organization.bestDiscountPercent}% off',
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
                        Container(
                          // statusxsq (I4902:29248;4902:23631)

                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xfff6f6f8),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Center(
                            child: Text(
                              'Offline',
                              style: TextStyle(
                                fontSize: 14,
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
