import 'dart:developer';
import 'dart:ui';

// ignore: library_prefixes
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// ignore: library_prefixes
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/omni_scheduling.dart';
import 'package:omni_video_call/src/core/models/remote_uid_model.dart';
import 'package:omni_video_call/src/video_call/pages/pip_mode_page.dart';
import 'package:omni_video_call/src/video_call/pages/video_call_out_coming_page.dart';
import 'package:omni_video_call/src/video_call/pages/widgets/call_permissions_widget.dart';
import 'package:omni_video_call/src/video_call/pages/widgets/video_call_bottom_toggle_buttons_widget.dart';
import 'package:omni_video_call/src/video_call/pages/widgets/video_call_header_toggle_buttons.dart';
import 'package:omni_video_call/src/video_call/stores/config_render_store.dart';
import 'package:omni_video_call/src/video_call/stores/video_call_out_comming_store.dart';
import 'package:omni_video_call/src/video_call/stores/video_call_store.dart';
import 'package:omni_video_call_labels/labels.dart';

class VideoCallPage extends StatefulWidget {
  final String docId;
  final String appointmentId;
  final String peerBeneficiary;
  final String professionalName;
  final String professionalImage;
  final String token;

  const VideoCallPage({
    Key? key,
    required this.docId,
    required this.appointmentId,
    required this.peerBeneficiary,
    required this.professionalName,
    required this.professionalImage,
    required this.token,
  }) : super(key: key);

  @override
  _VideoCallPageState createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  final VideoCallStore store = Modular.get();
  final Duration duration = const Duration(milliseconds: 250);
  late final AnimationController animationController;
  final VideoCallOutComingStore videoCallOutComingStore =
      VideoCallOutComingStore();
  final GlobalKey remoteRender = GlobalKey();
  final GlobalKey localRender = GlobalKey();
  SchedulingDetailsBeneficiaryStore beneficiaryStore = Modular.get();
  ProfessionalStatusStore professionalStatusStore = Modular.get();

  bool muted = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    store.permissionStore.getCallPermissionsStatus();
    store.initDocumentReference(widget.docId, widget.appointmentId);
    animationController = AnimationController(vsync: this, duration: duration);

    store.initEngine(context);
    super.initState();
    _changeInit();
  }

  Future<void> _changeInit() async {
    await Future.delayed(
      const Duration(seconds: 12),
    ).then((value) {
      store.configStore.changeFullScreen();
    });
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.detached:
        if (store.state) {
          await store.finishCall(widget.peerBeneficiary);
        }
        break;
      default:
        break;
    }
  }

  @override
  void didChangeDependencies() {
    FocusScope.of(context).requestFocus(FocusNode());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    WidgetsBinding.instance.removeObserver(this);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<VideoCallStore, Exception, bool>(
      store: store,
      builder: (_, triple) {
        if (triple.state) {
          return _buildMilpleVideoRenderWidget(context);
        }

        return VideoCallOutComingPage(
          key: widget.key,
          docId: widget.docId,
          appointmentId: widget.appointmentId,
          peerBeneficiary: widget.peerBeneficiary,
          professionalImage: widget.professionalImage,
          professionalName: widget.professionalName,
          token: widget.token,
          // throughNotification: widget.throughNotification,
        );
      },
    );
  }

  Widget _buildMilpleVideoRenderWidget(BuildContext pipContext) {
    return SafeArea(
      top: false,
      left: false,
      right: false,
      child: Scaffold(
        body: TripleBuilder(
          store: store.configStore,
          builder: (_, triple) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  _buildHeaderToggleButtonsWidget(pipContext),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _viewRows(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SafeArea(
                            bottom: false,
                            child: _buildBottomToggleButtonsWidget,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _getRenderViews() {
    final List<Widget> viewsList = [];
    viewsList.add(
      Stack(
        children: [
          const RtcLocalView.SurfaceView(),
          Visibility(
            visible: store.configStore.videoEnabled == false ||
                store.configStore.audioEnabled == false,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: store.remoteUid.length > 2
                    ? Border.all(
                        color: Theme.of(context).colorScheme.background,
                      )
                    : null,
                color: store.configStore.videoEnabled == false
                    ? Colors.black
                    : store.configStore.audioEnabled == false
                        ? Colors.black.withOpacity(0.5)
                        : null,
              ),
              child: _buildMutedComponents(
                store.configStore.videoEnabled == false,
                store.configStore.audioEnabled == false,
                25,
              ),
            ),
          ),
        ],
      ),
    );
    store.remoteUid.forEach(
      (model) {
        viewsList.add(
          Stack(
            children: [
              RtcRemoteView.SurfaceView(
                uid: model.uid!,
                channelId: '',
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.background,
                  ),
                  color: model.videoDisabbled! == true
                      ? Colors.black
                      : model.audioDisabled! == true
                          ? Colors.black.withOpacity(0.5)
                          : null,
                ),
                child: _buildMutedComponents(
                  model.videoDisabbled!,
                  model.audioDisabled!,
                  25,
                ),
              ),
            ],
          ),
        );
      },
    );

    return viewsList;
  }

  Widget _videoView(Widget view) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          store.configStore.changeFullScreen();
        },
        child: Container(
          child: view,
        ),
      ),
    );
  }

  Widget _expandedVideoRow(List<Widget> views) {
    final wrappedViews = views.map<Widget>(_videoView).toList();
    return Expanded(
      child: GestureDetector(
        onTap: () {
          store.configStore.changeFullScreen();
        },
        child: Row(
          children: wrappedViews,
        ),
      ),
    );
  }

  Widget _viewRows() {
    final views = _getRenderViews();
    switch (views.length) {
      case 1:
        return Column(
          children: <Widget>[_videoView(views.first)],
        );
      case 2:
        return PIPModePage(
          onStartFloating: () {
            store.configStore.changeFullScreen();
            SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.manual,
              overlays: SystemUiOverlay.values,
            );
          },
          onStopFloating: () {
            store.configStore.changeFullScreen();
          },
          floatingWidth: MediaQuery.of(context).size.width * 0.275,
          floatingHeight: MediaQuery.of(context).size.height * 0.225,
          animationDuration: 250,
          builder: (pipContext, isFloating) {
            store.configStore.changePIPMode(isFloating);
            return _buildVideosRenderWidget(pipContext);

            // return TripleBuilder<VideoCallStore, Exception, bool>(
            //   store: store,
            //   builder: (_, triple) {
            //     if (triple.state) {
            //       return _buildVideosRenderWidget(pipContext);
            //     }
            //     return VideoCallOutComingPage(
            //       key: widget.key,
            //       docId: widget.docId,
            //       appointmentId: widget.appointmentId,
            //       peerBeneficiary: widget.peerBeneficiary,
            //       professionalImage: widget.professionalImage,
            //       professionalName: widget.professionalName,
            //       token: widget.token,
            //     );
            //   },
            // );
          },
        );
      case 3:
        return Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: [
                  _expandedVideoRow(views.sublist(0, 1)),
                  _expandedVideoRow(views.sublist(2)),
                ],
              ),
            ),
            _expandedVideoRow(views.sublist(1, 2)),
          ],
        );
      case 4:
        return Column(
          children: <Widget>[
            _expandedVideoRow(views.sublist(0, 2)),
            _expandedVideoRow(views.sublist(2, 4))
          ],
        );
      default:
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topLeft,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: views.length - 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index != 1) {
                      return Container(
                        key: Key(index.toString()),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Column(
                            children: [
                              Expanded(
                                child: ColoredBox(
                                  color: Colors.black,
                                  child: Stack(
                                    children: [
                                      const Center(
                                        child: Text(
                                          VideoCallLabels.videoCallLocalUser,
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          _expandedVideoRow([views[index]]),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.759,
                child: views[1],
              ),
            ],
          ),
        );
    }
  }

  Widget _buildMutedComponents(
    bool videoEnabled,
    bool audioEnabled,
    double? iconSize,
  ) {
    return Row(
      children: [
        Visibility(
          visible: audioEnabled,
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.only(
                left: 10,
                top: 10,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.mic_off,
                color: Theme.of(context).colorScheme.background,
                size: iconSize,
              ),
            ),
          ),
        ),
        Visibility(
          visible: videoEnabled,
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.only(
                left: 10,
                top: 10,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.videocam_off_rounded,
                color: Theme.of(context).colorScheme.background,
                size: iconSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideosRenderWidget(BuildContext pipContext) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ColoredBox(
        color: Theme.of(context).cardColor.withOpacity(0.75),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _primaryVideoRenderWidget,
                  _secondaryVideoRenderWidget,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _primaryVideoRenderWidget {
    return GestureDetector(
      onTap: () {
        store.configStore.changeFullScreen();
      },
      child: TripleBuilder(
        store: store.permissionStore,
        builder: (_, triple) {
          return ScopedBuilder(
            store: store.configStore,
            onLoading: (context) => const LoadingWidget(),
            onState: (_, state) {
              return Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: store.configStore.videoEnabled ? 0 : 5,
                      sigmaY: store.configStore.videoEnabled ? 0 : 5,
                    ),
                    child: ColoredBox(
                      key: remoteRender,
                      color: Theme.of(context).cardColor.withOpacity(0.75),
                      child: Builder(
                        builder: (_) {
                          if (store.remoteUid.isEmpty) {
                            return const LoadingWidget();
                          }
                          return _buildVideoCallScreen(
                            store.remoteUid.first,
                          );
                        },
                      ),
                    ),
                  ),
                  _buildCallPermissionsWidget,
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget get _buildCallPermissionsWidget {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.1,
          ),
          child: CallPermissionsWidget(
            store: store.permissionStore,
          ),
        ),
      ),
    );
  }

  Widget get _secondaryVideoRenderWidget {
    return TripleBuilder(
      store: store.configStore,
      builder: (_, state) {
        return AnimatedAlign(
          duration: Duration.zero,
          alignment: store.configStore.pipMode
              ? Alignment.topRight
              : store.configStore.state,
          child: AnimatedPadding(
            duration: duration,
            padding: EdgeInsets.symmetric(
              vertical: store.configStore.pipMode ? 40 : 10,
              horizontal: store.configStore.pipMode ? 10 : 10,
            ),
            child: Draggable(
              onDragEnd: (DraggableDetails details) {
                store.configStore.updateAlignment(
                  details.offset,
                  MediaQuery.of(context).size,
                );
              },
              feedback: _secondaryVideoRenderWidget,
              childWhenDragging: const SizedBox(),
              child: GestureDetector(
                onTap: () {
                  log('pipMode pressed');
                },
                child: Container(
                  key: localRender,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: store.configStore.videoEnabled
                          ? Colors.transparent
                          : Theme.of(context).colorScheme.background,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: store.configStore.videoEnabled
                        ? Theme.of(context).cardColor.withOpacity(0.75)
                        : Colors.black,
                  ),
                  width: MediaQuery.of(context).size.width * 0.275,
                  height: MediaQuery.of(context).size.height * 0.225,
                  child: Stack(
                    children: [
                      Visibility(
                        visible: store.configStore.videoEnabled,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: const RtcLocalView.SurfaceView(),
                        ),
                      ),
                      _buildMutedComponents(
                        store.configStore.videoEnabled == false,
                        store.configStore.audioEnabled == false,
                        25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderToggleButtonsWidget(BuildContext pipContext) {
    return TripleBuilder<ConfigRenderStore, Exception, Alignment>(
      store: store.configStore,
      builder: (_, triple) {
        return AnimatedSwitcher(
          duration: duration,
          transitionBuilder: (child, animation) {
            final Animation<Offset> offset = Tween<Offset>(
              begin: const Offset(0.0, -1.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.decelerate),
            );
            return SlideTransition(position: offset, child: child);
          },
          child: store.configStore.fullScreen
              ? const SafeArea(bottom: false, child: SizedBox())
              : VideoCallHeaderToggleButtons(
                  startFloating: () {
                    PIPModePage.of(pipContext)!.startFloating();

                    store.configStore.forceUpdate();
                  },
                ),
        );
      },
    );
  }

  Widget get _buildBottomToggleButtonsWidget {
    return TripleBuilder<ConfigRenderStore, Exception, Alignment>(
      store: store.configStore,
      builder: (_, triple) {
        return AnimatedSwitcher(
          duration: duration,
          transitionBuilder: (child, animation) {
            final Animation<Offset> offset = Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(parent: animation, curve: Curves.decelerate),
            );
            return SlideTransition(position: offset, child: child);
          },
          child: store.configStore.fullScreen
              ? const SafeArea(top: false, bottom: false, child: SizedBox())
              : VideoCallBottomToggleButtonsWidget(
                  professionalImage: widget.professionalImage,
                  professionalName: widget.professionalName,
                  peerBeneficiary: widget.peerBeneficiary,
                ),
        );
      },
    );
  }

  Widget _buildVideoCallScreen(RemoteUidModel remoteUid) {
    return Stack(
      children: [
        RtcRemoteView.SurfaceView(
          uid: remoteUid.uid!,
          channelId: '',
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: remoteUid.videoDisabbled! == true
                ? Colors.black
                : remoteUid.audioDisabled! == true
                    ? Colors.black.withOpacity(0.5)
                    : null,
          ),
          child: _buildMutedComponents(
            remoteUid.videoDisabbled!,
            remoteUid.audioDisabled!,
            25,
          ),
        ),
      ],
    );
  }
}
