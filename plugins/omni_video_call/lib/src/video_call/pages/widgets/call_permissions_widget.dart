import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_video_call/src/video_call/stores/call_permission_store.dart';
import 'package:omni_video_call_labels/labels.dart';
import 'package:permission_handler/permission_handler.dart';

class CallPermissionsWidget extends StatefulWidget {
  final CallPermissionStore store;
  const CallPermissionsWidget({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  _CallPermissionsWidgetState createState() => _CallPermissionsWidgetState();
}

class _CallPermissionsWidgetState extends State<CallPermissionsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TripleBuilder(
          store: widget.store,
          builder: (_, triple) {
            if (triple.isLoading) {
              return const SizedBox();
            }
            if (widget.store.cameraStatus == PermissionStatus.granted) {
              return const SizedBox();
            } else if (widget.store.cameraStatus ==
                PermissionStatus.permanentlyDenied) {
              return _buildRequestMessageWidget(
                message: VideoCallLabels.callPermissionsCameraConfigurations,
                onRequested: widget.store.openSettings,
              );
            }
            return _buildRequestMessageWidget(
              message: VideoCallLabels.callPermissionsCameraPermission,
              onRequested: widget.store.getCameraPermission,
            );
          },
        ),
        const SizedBox(height: 25),
        TripleBuilder(
          store: widget.store,
          builder: (_, triple) {
            if (triple.isLoading) {
              return const SizedBox();
            }
            if (widget.store.microphoneStatus == PermissionStatus.granted) {
              return const SizedBox();
            } else if (widget.store.microphoneStatus ==
                PermissionStatus.permanentlyDenied) {
              return _buildRequestMessageWidget(
                message:
                    VideoCallLabels.callPermissionsMicrophoneConfigurations,
                onRequested: widget.store.openSettings,
              );
            }
            return _buildRequestMessageWidget(
              message: VideoCallLabels.callPermissionsMicrophonePermission,
              onRequested: widget.store.getMicrophonePermission,
            );
          },
        ),
      ],
    );
  }

  Widget _buildRequestMessageWidget({
    required String message,
    required Function onRequested,
  }) {
    return ClipRRect(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black.withOpacity(0.25),
        ),
        padding: const EdgeInsets.all(5),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: InkWell(
            onTap: () => onRequested(),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.blue,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
