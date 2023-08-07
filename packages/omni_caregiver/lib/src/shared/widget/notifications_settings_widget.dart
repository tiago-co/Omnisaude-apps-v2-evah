import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:omni_caregiver_labels/labels.dart';

class NotificationsSettingsWidget extends StatefulWidget {
  final Function(bool) changeSmsValue;
  final Function(bool) changeEmailValue;
  final bool smsCheckValue;
  final bool emailCheckValue;

  const NotificationsSettingsWidget({
    Key? key,
    required this.changeSmsValue,
    required this.smsCheckValue,
    required this.changeEmailValue,
    required this.emailCheckValue,
  }) : super(key: key);

  @override
  _NotificationsSettingsWidgetState createState() =>
      _NotificationsSettingsWidgetState();
}

class _NotificationsSettingsWidgetState
    extends State<NotificationsSettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor.withOpacity(0.025),
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 0.5,
        ),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            CaregiverLabels.notificationsSettingsTitle,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.black,
                ),
          ),
          const SizedBox(height: 15),
          Text(
            CaregiverLabels.notificationsSettingsDescription,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 15),
          _buildCheckBoxWidget(
            value: widget.smsCheckValue,
            onChangeValue: widget.changeSmsValue,
          ),
          const Divider(),
          _buildCheckBoxWidget(
            title: CaregiverLabels.emailLabel,
            value: widget.emailCheckValue,
            onChangeValue: widget.changeEmailValue,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckBoxWidget({
    String title = CaregiverLabels.notificationsSettingsSMS,
    required bool value,
    required Function(bool) onChangeValue,
  }) {
    return Semantics(
      child: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ListTile(
          onTap: () {
            onChangeValue(!value);
          },
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                ),
          ),
          contentPadding: EdgeInsets.zero,
          trailing: CupertinoSwitch(
            value: value,
            trackColor: Theme.of(context).cardColor.withOpacity(0.25),
            activeColor: Theme.of(context).primaryColor,
            onChanged: (bool? checked) {
              onChangeValue(checked ?? value);
            },
          ),
        ),
      ),
    );
  }
}
