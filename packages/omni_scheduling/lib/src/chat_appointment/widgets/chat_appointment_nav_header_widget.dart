import 'package:flutter/material.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling/src/shared/widgets/professional_status_widget.dart';
import 'package:omni_scheduling_labels/labels.dart';

class ChatAppointmentNavHeaderWidget extends StatefulWidget {
  final SchedulingModel scheduling;

  const ChatAppointmentNavHeaderWidget({
    Key? key,
    required this.scheduling,
  }) : super(key: key);

  @override
  _ChatAppointmentNavHeaderWidgetState createState() =>
      _ChatAppointmentNavHeaderWidgetState();
}

class _ChatAppointmentNavHeaderWidgetState
    extends State<ChatAppointmentNavHeaderWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).cardColor.withOpacity(0.25),
            width: 0.5,
          ),
        ),
        color: Theme.of(context).colorScheme.background,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor.withOpacity(0.05),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).cardColor.withOpacity(0.1),
              ),
              padding: const EdgeInsets.all(2.5),
              child: ClipOval(
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.background,
                  child: ImageWidget(
                    url: widget.scheduling.professional!.image ?? '',
                    assetBase: Assets.doctorBase,
                    asset: Assets.doctor,
                    boxFit: BoxFit.cover,
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.scheduling.specialty?.name ?? SchedulingLabels.chatAppointmentNavHeaderWithoutSpecialty,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                  ),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Tooltip(
                      message: widget.scheduling.professional!.name,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(10),
                      preferBelow: true,
                      child: Text(
                        widget.scheduling.professional!.name!,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            const SchedulingProfessionalStatusWidget(),
          ],
        ),
      ),
    );
  }
}
