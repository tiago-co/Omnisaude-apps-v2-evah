import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/omni_bot.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/chat_appointment/stores/back_to_call_store.dart';
import 'package:omni_scheduling/src/chat_appointment/stores/chat_appointment_message_store.dart';
import 'package:omni_scheduling/src/chat_appointment/stores/chat_appointment_store.dart';
import 'package:omni_scheduling/src/chat_appointment/stores/chat_appointment_video_call_store.dart';
import 'package:omni_scheduling/src/chat_appointment/widgets/chat_apointment_panel_send_message.dart';
import 'package:omni_scheduling/src/chat_appointment/widgets/chat_appointment_floating_header_widget.dart';
import 'package:omni_scheduling/src/chat_appointment/widgets/chat_appointment_nav_header_widget.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_status_enum.dart';
import 'package:omni_scheduling/src/core/models/scheduling_model.dart';
import 'package:omni_scheduling/src/shared/stores/professional_status_store.dart';
import 'package:omni_scheduling_labels/labels.dart';
import 'package:omni_video_call/omni_video_call.dart';

class ChatAppointmentPage extends StatefulWidget {
  final SchedulingModel scheduling;

  const ChatAppointmentPage({
    Key? key,
    required this.scheduling,
  }) : super(key: key);

  @override
  _ChatAppointmentPageState createState() => _ChatAppointmentPageState();
}

class _ChatAppointmentPageState extends State<ChatAppointmentPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final ChatAppointmentStore store = Modular.get();
  final VideoCallOutComingStore videoCallOutComingStore = Modular.get();
  final UserStore userStore = Modular.get();
  final ScrollController scrollController = ScrollController();
  final Duration duration = const Duration(milliseconds: 250);
  final BackToCallStore backToCallStore = Modular.get();
  late AnimationController animationController;
  late Animation<double> animation1;
  late Animation<double> animation2;

  final GlobalKey headerKey = GlobalKey();

  void getOffset(GlobalKey key) {
    final dynamic render = key.currentContext!.findRenderObject();
    final Offset childOffset = render.localToGlobal(Offset.zero);
    final Size childSize = render.size!;
    if (childOffset.dy <= childSize.height / 2 * -1) {
      if (animationController.isDismissed) {
        animationController.forward();
      }
    } else {
      if (animationController.isCompleted) {
        animationController.reverse();
      }
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    animationController = AnimationController(vsync: this, duration: duration);
    animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      animationController,
    );
    animation2 = Tween<double>(begin: 1.0, end: 0.0).animate(
      animationController,
    );
    scrollController.addListener(() {
      getOffset(headerKey);
    });
    store.messageStore.avatarUrl = '';
    store.messageStore.username = userStore.state.user!.individualPerson!.name;
    store.messageStore.listenMessages(widget.scheduling);
    store.videoCallStore.listenVideoCalls(widget.scheduling);
    super.initState();
  }

  @override
  void dispose() {
    store.beneficiaryStore.setBeneficiaryExitStatus(widget.scheduling);
    animationController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        store.beneficiaryStore.setBeneficiaryIntoStatus(widget.scheduling);
        break;
      case AppLifecycleState.inactive:
        store.beneficiaryStore.setBeneficiaryExitStatus(widget.scheduling);
        break;
      case AppLifecycleState.paused:
        store.beneficiaryStore.setBeneficiaryExitStatus(widget.scheduling);
        break;
      case AppLifecycleState.detached:
        store.beneficiaryStore.setBeneficiaryExitStatus(widget.scheduling);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<ChatAppointmentVideoCallStore, Exception, bool>(
      store: store.videoCallStore,
      builder: (_, triple) {
        return Stack(
          fit: StackFit.expand,
          children: [
            _buildChatBodyWidget,
            if (triple.state)
              VideoCallPage(
                key: ObjectKey(triple.state),
                docId: store.videoCallStore.docId,
                appointmentId: widget.scheduling.appointment!.id!,
                peerBeneficiary: widget.scheduling.peerBeneficiary!,
                professionalName:
                    widget.scheduling.professional?.name ?? SchedulingLabels.chatAppointmentProfessionalPlaceholder,
                professionalImage: widget.scheduling.professional?.image ?? '',
                token: store.videoCallStore.token ?? '',
              ),
          ],
        );
      },
    );
  }

  Widget get _buildChatBodyWidget {
    return Scaffold(
      appBar: NavBarWidget(
        title: widget.scheduling.specialty?.name ?? SchedulingLabels.chatAppointmentSpecialtyPlaceholder,
      ).build(context) as AppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                videoCallOutComingStore.acceptCall(
                  widget.scheduling.peerBeneficiary!,
                  widget.scheduling.appointment!.id!,
                  store.videoCallStore.token ?? '',
                );
              },
              child: TripleBuilder(
                store: store.videoCallStore.backToCallStore,
                builder: (_, triple) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(
                      top: 15,
                      left: 10,
                      right: 10,
                    ),
                    alignment: Alignment.center,
                    height: backToCallStore.state ? MediaQuery.of(context).size.height * 0.05 : 0,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.phone_callback_sharp,
                          color: Theme.of(context).colorScheme.background,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          SchedulingLabels.chatAppointmentBackCall,
                          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            AnimatedBuilder(
              animation: animationController,
              builder: (_, child) {
                return FadeTransition(
                  opacity: animation1,
                  child: SizeTransition(
                    sizeFactor: animation1,
                    child: ChatAppointmentNavHeaderWidget(
                      scheduling: widget.scheduling,
                    ),
                  ),
                );
              },
            ),
            Expanded(
              child: TripleBuilder<ProfessionalStatusStore, Exception, bool>(
                store: store.professionalStatusStore,
                builder: (_, triple) {
                  late final bool isBottomSafe;
                  if (widget.scheduling.status == SchedulingStatus.attended) {
                    isBottomSafe = true;
                  } else {
                    if (triple.state) {
                      isBottomSafe = false;
                    } else {
                      isBottomSafe = true;
                    }
                  }

                  return SingleChildScrollView(
                    reverse: true,
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    padding: const EdgeInsets.only(top: 20),
                    child: SafeArea(
                      bottom: isBottomSafe,
                      child: Column(
                        children: [
                          ChatAppointmentFloatingHeaderWidget(
                            animationController: animationController,
                            animation: animation2,
                            scheduling: widget.scheduling,
                            headerKey: headerKey,
                          ),
                          _buildMessageListWidget,
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            TripleBuilder<ProfessionalStatusStore, Exception, bool>(
              store: store.professionalStatusStore,
              builder: (_, triple) {
                if (widget.scheduling.status == SchedulingStatus.attended) {
                  return const SizedBox();
                }
                if (!triple.state) {
                  return const SizedBox();
                }
                return ChatAppointmentPanelSendMessage(
                  botMessageModel: BotMessageModel(),
                  onSendMessage: (BotMessageModel message) async {
                    await store.messageStore.onSendMessage(
                      message,
                      widget.scheduling,
                    );
                  },
                  onSendFile: (BotMessageModel message) async {
                    await store.messageStore.onUploadFile(
                      message,
                      widget.scheduling,
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildMessageListWidget {
    return TripleBuilder<ChatAppointmentMessageStore, Exception, List<BotMessageModel>>(
      store: store.messageStore,
      builder: (_, triple) {
        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: triple.state.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          itemBuilder: (_, index) {
            if (triple.state.length > 1) getOffset(headerKey);
            return RenderMessageWidget(
              botMessage: triple.state[index],
              lastBotMessage: triple.state.last,
              connection: store.messageStore.connection,
            );
          },
        );
      },
    );
  }
}
