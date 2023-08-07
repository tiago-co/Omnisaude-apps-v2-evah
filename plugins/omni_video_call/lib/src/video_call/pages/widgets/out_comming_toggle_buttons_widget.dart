import 'package:flutter/material.dart';
import 'package:omni_video_call/src/video_call/stores/video_call_out_comming_store.dart';
import 'package:omni_video_call_labels/labels.dart';

class OutCommingToggleButtonsWidget extends StatefulWidget {
  final String peerBeneficiary;
  final String channelName;
  final String token;
  final VideoCallOutComingStore store;

  const OutCommingToggleButtonsWidget({
    Key? key,
    required this.peerBeneficiary,
    required this.channelName,
    required this.store,
    required this.token,
  }) : super(key: key);

  @override
  _OutCommingToggleButtonsWidgetState createState() =>
      _OutCommingToggleButtonsWidgetState();
}

class _OutCommingToggleButtonsWidgetState
    extends State<OutCommingToggleButtonsWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        widget.store.videoCallStore.permissionStore.requestPermissions();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: _buildDeclineToggleButtonWidget,
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildAcceptToggleButtonWidget,
        ),
      ],
    );
  }

  Widget get _buildDeclineToggleButtonWidget {
    return Column(
      children: [
        GestureDetector(
          onTap: () => widget.store.declineCall(widget.peerBeneficiary),
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.call_end_rounded,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          VideoCallLabels.outCommingToggleButtonsReject,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white,
              ),
        ),
      ],
    );
  }

  Widget get _buildAcceptToggleButtonWidget {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            widget.store.acceptCall(
              widget.peerBeneficiary,
              widget.channelName,
              widget.token,
            );
          },
          child: Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.call_rounded,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          VideoCallLabels.outCommingToggleButtonsAccept,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Colors.white,
              ),
        ),
      ],
    );
  }
}
