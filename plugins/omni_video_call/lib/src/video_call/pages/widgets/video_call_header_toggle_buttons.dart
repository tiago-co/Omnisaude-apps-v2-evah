import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:omni_video_call/omni_video_call.dart';
import 'package:omni_video_call/src/video_call/stores/call_duration_store.dart';

class VideoCallHeaderToggleButtons extends StatefulWidget {
  final VoidCallback startFloating;

  const VideoCallHeaderToggleButtons({
    Key? key,
    required this.startFloating,
  }) : super(key: key);

  @override
  _VideoCallHeaderToggleButtonsState createState() =>
      _VideoCallHeaderToggleButtonsState();
}

class _VideoCallHeaderToggleButtonsState
    extends State<VideoCallHeaderToggleButtons> {
  final VideoCallStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: SafeArea(
            bottom: false,
            child: Row(
              children: [
                const SizedBox(width: 15),
                Expanded(child: _buildCallDurationWidget),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget get _buildCallDurationWidget {
    return TripleBuilder<CallDurationStore, Exception, DateTime>(
      store: store.callDurationStore,
      builder: (_, triple) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('mm:ss').format(triple.state),
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        );
      },
    );
  }
}
