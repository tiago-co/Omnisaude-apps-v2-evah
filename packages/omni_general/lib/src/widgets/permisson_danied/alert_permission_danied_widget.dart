import 'package:flutter/material.dart';
import 'package:omni_general/src/widgets/permisson_danied/button_alert_widget.dart';
import 'package:omni_general_labels/labels.dart';
import 'package:permission_handler/permission_handler.dart';

class AlertPermissionDaniedWidget extends StatefulWidget {
  final String? title;
  final String? permission;
  final String? message;
  final String? buttonTextOk;
  final String? buttonTextCancel;
  final void Function()? onPressedOK;
  final void Function()? onPressedCancel;
  final Color? color;

  const AlertPermissionDaniedWidget({
    Key? key,
    this.title,
    required this.permission,
    this.message,
    this.buttonTextOk,
    this.buttonTextCancel,
    this.onPressedOK,
    this.onPressedCancel,
    this.color,
  }) : super(key: key);

  @override
  State<AlertPermissionDaniedWidget> createState() =>
      _AlertPermissionDaniedWidgetState();
}

class _AlertPermissionDaniedWidgetState
    extends State<AlertPermissionDaniedWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width / 1.4,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              offset: const Offset(12, 26),
              blurRadius: 50,
              color: Colors.grey.withOpacity(.1),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: widget.color ?? Theme.of(context).primaryColor,
              radius: 25,
              child: const Icon(
                Icons.warning,
                color: Colors.white,
                size: 25,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.title ?? GeneralLabels.alertPermissionDanied,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.message ??
                  '${GeneralLabels.alertPermissionDaniedDescription} ${widget.permission}',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonAlertWidget(
                  text: widget.buttonTextCancel ??
                      GeneralLabels.alertPermissionDaniedCancel,
                  onPressed: widget.onPressedCancel ??
                      () {
                        Navigator.of(context).pop();
                      },
                  primaryColor: widget.color,
                  invertedColors: true,
                ),
                ButtonAlertWidget(
                  text: widget.buttonTextOk ??
                      GeneralLabels.alertPermissionDaniedContinue,
                  onPressed: widget.onPressedOK ??
                      () {
                        openAppSettings();
                      },
                  primaryColor: widget.color,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
