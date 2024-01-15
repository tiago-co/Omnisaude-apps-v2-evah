import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnabledNotificationWidget extends StatefulWidget {
  final String? title;
  const EnabledNotificationWidget({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  State<EnabledNotificationWidget> createState() =>
      _EnabledNotificationWidgetState();
}

class _EnabledNotificationWidgetState extends State<EnabledNotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.title ?? '',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            trailing: Platform.isIOS
                ? CupertinoSwitch(
                    value: true,
                    onChanged: (value) => {},
                  )
                : Switch(
                    value: true,
                    onChanged: (value) => {},
                  ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
