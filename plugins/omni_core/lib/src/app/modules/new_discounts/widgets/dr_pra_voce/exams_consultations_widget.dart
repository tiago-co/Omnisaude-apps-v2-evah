import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/presential_consultation/widgets/discount_info_bottom_sheet/discounts_info_bottom_sheet.dart';

class ExamsConsultationWidget extends StatelessWidget {
  const ExamsConsultationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        anchorPoint: Offset(0, 25),
        builder: (context) => const DiscountsInfoBottomSheet(),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              Assets.examsIcon,
              package: AssetsPackage.omniCore,
              color: Theme.of(context).primaryColor,
              width: 24,
              height: 24,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Exames e consultas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                Text(
                  'Veja os descontos disponíveis',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
