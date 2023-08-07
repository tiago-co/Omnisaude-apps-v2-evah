import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/widgets/colored_corner_widget.dart';
import 'package:omni_general/omni_general.dart';

class OrganizationTileWidget extends StatelessWidget {
  final OrganizationModel organization;
  final String? rescueType;
  final String moduleName;

  const OrganizationTileWidget({
    Key? key,
    required this.moduleName,
    required this.organization,
    required this.rescueType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Modular.to.pushNamed(
          'cupons',
          arguments: {
            'organizationId': organization.id,
            'moduleName': moduleName,
            'coverImage': organization.coverPicture,
            'couponRescueType': rescueType
          },
        );
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
          ),
        ),
        child: ColoredCornerWidget(
          color: Colors.yellowAccent,
          discountPercentage: organization.bestDiscountPercent!.toString(),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 25),
                  margin: const EdgeInsets.only(right: 80.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
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
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          organization.name!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
