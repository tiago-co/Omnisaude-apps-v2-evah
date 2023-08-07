// ignore: library_prefixes
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_video_call/src/video_call/pages/widgets/call_permissions_widget.dart';
import 'package:omni_video_call/src/video_call/pages/widgets/out_comming_toggle_buttons_widget.dart';
import 'package:omni_video_call/src/video_call/stores/video_call_out_comming_store.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallOutComingPage extends StatefulWidget {
  final String docId;
  final String appointmentId;
  final String peerBeneficiary;
  final String professionalName;
  final String professionalImage;
  final String token;
  // final bool throughNotification;

  const VideoCallOutComingPage({
    Key? key,
    required this.docId,
    required this.appointmentId,
    required this.peerBeneficiary,
    required this.professionalName,
    required this.professionalImage,
    required this.token,
    // required this.throughNotification,
  }) : super(key: key);

  @override
  _VideoCallOutComingPageState createState() => _VideoCallOutComingPageState();
}

class _VideoCallOutComingPageState extends State<VideoCallOutComingPage> {
  final VideoCallOutComingStore store = VideoCallOutComingStore();

  @override
  void didChangeDependencies() {
    FocusScope.of(context).requestFocus(FocusNode());
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    store.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TripleBuilder(
          store: store.videoCallStore.permissionStore,
          builder: (_, triple) {
            return ScopedBuilder(
              store: store.videoCallStore,
              onState: (_, state) {
                return Scaffold(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  body: ColoredBox(
                    color: Theme.of(context).cardColor.withOpacity(0.75),
                    child: Stack(
                      children: [
                        if (store.videoCallStore.permissionStore.cameraStatus ==
                            PermissionStatus.granted)
                          const RtcLocalView.SurfaceView(),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: SafeArea(
                            child: _buildProfessionalCallHeaderWidget,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 30,
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: OutCommingToggleButtonsWidget(
                peerBeneficiary: widget.peerBeneficiary,
                channelName: widget.appointmentId,
                token: widget.token,
                store: store,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget get _buildProfessionalCallHeaderWidget {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height * 0.1,
      ),
      child: Column(
        children: [
          RippleAnimation(
            color: Theme.of(context).primaryColor,
            minRadius: 65,
            child: Container(
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.background.withOpacity(0.25),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(5),
              child: ClipOval(
                child: AbsorbPointer(
                  child: ImageWidget(
                    url: widget.professionalImage,
                    boxFit: BoxFit.cover,
                    height: MediaQuery.of(context).size.width * 0.35,
                    width: MediaQuery.of(context).size.width * 0.35,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            child: Text(
              widget.professionalName,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
            ),
            child: CallPermissionsWidget(
              store: store.videoCallStore.permissionStore,
            ),
          ),
        ],
      ),
    );
  }
}
