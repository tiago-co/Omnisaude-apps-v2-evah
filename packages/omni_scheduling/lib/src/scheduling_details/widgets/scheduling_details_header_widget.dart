import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling/src/scheduling_details/stores/scheduling_details_store.dart';
import 'package:omni_scheduling/src/shared/widgets/professional_status_widget.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingDetailsHeaderWidget extends StatelessWidget {
  final SchedulingModel scheduling;
  final SchedulingDetailsStore store = Modular.get();

  SchedulingDetailsHeaderWidget({
    Key? key,
    required this.scheduling,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsets.only(bottom: 10),
              child: ClipOval(
                child: ColoredBox(
                  color: Theme.of(context).cardColor.withOpacity(0.1),
                  child: ImageWidget(
                    height: 75,
                    width: 75,
                    boxFit: BoxFit.cover,
                    assetBase: Assets.doctorBase,
                    asset: Assets.doctor,
                    url: scheduling.professional?.image ?? '',
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Flexible(
                    child: ColoredBox(
                      color: Colors.white,
                      child: SchedulingProfessionalStatusWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Text(
                  '${scheduling.professional?.name}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              _buildSpecialtyWidget(context),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Text(
                  '${scheduling.professional?.typeCR}'
                  '${scheduling.professional?.numberCR}/'
                  '${scheduling.professional?.ufCR}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSpecialtyWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            scheduling.specialty?.name ??
                SchedulingLabels.schedulingDetailsHeaderEmptySpecialty,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
          ),
        ),
      ],
    );
  }
}
