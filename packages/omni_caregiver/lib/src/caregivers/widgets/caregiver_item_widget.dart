import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_caregiver/src/core/models/caregiver_model.dart';
import 'package:omni_caregiver_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

class CaregiverItemWidget extends StatelessWidget {
  final CaregiverModel caregiver;

  const CaregiverItemWidget({
    Key? key,
    required this.caregiver,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalTimelineItemWidget(
      child: GestureDetector(
        onTap: () {
          Modular.to.pushNamed('caregiverDetails', arguments: caregiver);
        },
        child: ColoredBox(
          color: Colors.transparent,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      caregiver.name ?? CaregiverLabels.caregiversEmptyName,
                      overflow: TextOverflow.ellipsis,
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          color: Theme.of(context).cardColor.withOpacity(0.5),
                          size: 18,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              // ignore: lines_longer_than_80_chars
                              '${caregiver.phones?.length != null && caregiver.phones!.isNotEmpty ? caregiver.phones!.first.isNotEmpty ? Formaters.formatPhone(caregiver.phones!.first) : CaregiverLabels.caregiversEmptyPhone : CaregiverLabels.caregiversEmptyPhone} '
                              // ignore: lines_longer_than_80_chars
                              '${caregiver.phones?.length != null && caregiver.phones!.length > 1 ? '+${caregiver.phones!.length - 1}' : ''}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: Theme.of(context).cardColor.withOpacity(0.5),
                          size: 18,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              // ignore: lines_longer_than_80_chars
                              '${caregiver.emails?.length != null && caregiver.emails!.isNotEmpty ? caregiver.emails!.first.isNotEmpty ? caregiver.emails!.first : CaregiverLabels.caregiversEmptyEmail : CaregiverLabels.caregiversEmptyEmail} '
                              // ignore: lines_longer_than_80_chars
                              '${caregiver.emails?.length != null && caregiver.emails!.length > 1 ? '+${caregiver.emails!.length - 1}' : ''}',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(width: 15),
              SvgPicture.asset(
                Assets.arrowRight,
                color: Theme.of(context).primaryColor,
                package: AssetsPackage.omniGeneral,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
