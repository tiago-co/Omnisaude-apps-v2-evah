import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/omni_bot.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/chat_appointment/stores/chat_appointment_message_store.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling/src/shared/widgets/professional_status_widget.dart';
import 'package:omni_scheduling_labels/labels.dart';

class ChatAppointmentFloatingHeaderWidget extends StatefulWidget {
  final AnimationController animationController;
  final Animation<double> animation;
  final SchedulingModel scheduling;
  final GlobalKey headerKey;

  const ChatAppointmentFloatingHeaderWidget({
    Key? key,
    required this.animationController,
    required this.animation,
    required this.scheduling,
    required this.headerKey,
  }) : super(key: key);

  @override
  _ChatAppointmentFloatingHeaderWidgetState createState() =>
      _ChatAppointmentFloatingHeaderWidgetState();
}

class _ChatAppointmentFloatingHeaderWidgetState
    extends State<ChatAppointmentFloatingHeaderWidget> {
  final ChatAppointmentMessageStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<ChatAppointmentMessageStore, Exception,
        List<BotMessageModel>>(
      key: widget.headerKey,
      store: store,
      builder: (_, triple) {
        switch (store.connection.connectionStatus) {
          case ConnectionStatus.waiting:
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LoadingWidget(),
                  const SizedBox(height: 15),
                  Text(
                    SchedulingLabels.chatAppointmentFloatingHeaderWaiting,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            );
          default:
            break;
        }
        return AnimatedBuilder(
          animation: widget.animationController,
          builder: (_, child) {
            return FadeTransition(
              opacity: widget.animation,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.15,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor.withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: ClipOval(
                        child: ColoredBox(
                          color: Theme.of(context).colorScheme.background,
                          child: ImageWidget(
                            url: widget.scheduling.professional?.image ?? '',
                            assetBase: Assets.doctorBase,
                            asset: Assets.doctor,
                            boxFit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.scheduling.professional!.name!,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 15),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: SchedulingLabels
                            .chatAppointmentFloatingHeaderProfessional,
                        style: Theme.of(context).textTheme.titleLarge,
                        children: [
                          if (widget.scheduling.specialty?.name == null)
                            const TextSpan(
                              text: SchedulingLabels
                                  .chatAppointmentFloatingHeaderWithoutSpecialty,
                            ),
                          if (widget.scheduling.specialty?.name != null)
                            const TextSpan(
                              text: SchedulingLabels
                                  .chatAppointmentFloatingHeaderWithSpecialty,
                            ),
                          if (widget.scheduling.specialty?.name != null)
                            TextSpan(text: widget.scheduling.specialty!.name)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const SchedulingProfessionalStatusWidget(),
                    const SizedBox(height: 5),
                    const Divider(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
