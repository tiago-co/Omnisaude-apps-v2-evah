import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_video_call/omni_video_call.dart';
import 'package:omni_video_call/src/core/enums/camera_type_enum.dart';

class VideoCallBottomToggleButtonsWidget extends StatefulWidget {
  final String professionalName;
  final String professionalImage;
  final String peerBeneficiary;

  const VideoCallBottomToggleButtonsWidget({
    Key? key,
    required this.professionalName,
    required this.professionalImage,
    required this.peerBeneficiary,
  }) : super(key: key);

  @override
  _VideoCallBottomToggleButtonsWidgetState createState() =>
      _VideoCallBottomToggleButtonsWidgetState();
}

class _VideoCallBottomToggleButtonsWidgetState
    extends State<VideoCallBottomToggleButtonsWidget>
    with SingleTickerProviderStateMixin {
  final VideoCallStore store = Modular.get();
  final Duration duration = const Duration(milliseconds: 250);
  late final AnimationController animationController;
  late final Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: duration);
    animation = Tween<double>(begin: 0, end: 1).animate(animationController);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            child: AnimatedBuilder(
              animation: animationController,
              builder: (BuildContext context, Widget? child) {
                return Column(
                  children: [
                    child!,
                    FadeTransition(
                      opacity: animation,
                      child: SizeTransition(
                        sizeFactor: animation,
                        child: _buildCallInfoWidget,
                      ),
                    ),
                  ],
                );
              },
              child: _buildCallButtonsWidget,
            ),
          ),
        ),
      ],
    );
  }

  Widget get _buildCallInfoWidget {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.75),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.1),
                  ),
                  padding: const EdgeInsets.all(2.5),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: ClipOval(
                    child: AbsorbPointer(
                      child: ImageWidget(
                        url: widget.professionalImage,
                        boxFit: BoxFit.cover,
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Text(
                      widget.professionalName,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  Widget get _buildCallButtonsWidget {
    return TripleBuilder(
      store: store.configStore,
      builder: (_, triple) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                store.finishCall(widget.peerBeneficiary);
              },
              child: Container(
                padding: const EdgeInsets.all(7.5),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.call_end_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (animationController.isCompleted) {
                        animationController.reverse();
                      } else {
                        animationController.forward();
                      }
                    },
                    child: const Icon(
                      Icons.info_sharp,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      store.switchCamera();
                    },
                    child: Icon(
                      store.configStore.cameraType == CameraType.front
                          ? Icons.camera_front_rounded
                          : Icons.camera_rear_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await store
                          .enableLocalVideo(!store.configStore.videoEnabled);
                    },
                    child: Icon(
                      store.configStore.videoEnabled
                          ? Icons.videocam_rounded
                          : Icons.videocam_off_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      store.enableLocalAudio(!store.configStore.audioEnabled);
                    },
                    child: Icon(
                      store.configStore.audioEnabled
                          ? Icons.mic_rounded
                          : Icons.mic_off_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
