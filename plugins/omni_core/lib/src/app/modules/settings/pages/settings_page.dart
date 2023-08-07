import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/settings/pages/widgets/settings_item_list_widget.dart';
import 'package:omni_core/src/app/modules/settings/stores/settings_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:settings_labels/labels.dart';

class SettingsPage extends StatefulWidget {
  final String? title;
  const SettingsPage({Key? key, this.title = 'Configurações'})
      : super(key: key);
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final SettingsStore store = Modular.get();
  final UseBiometricsStore useBiometricsStore = Modular.get();
  final PreferencesService preferencesService = PreferencesService();

  @override
  void initState() {
    super.initState();
    _getBiometrics();
  }

  _getBiometrics() async {
    final hasBiometrics = await useBiometricsStore.getHasBiometrics();
    useBiometricsStore.updateState(hasBiometrics);
  }

  final PreferencesService service = PreferencesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: SettingsLabels.settingsTitle,
      ).build(context) as AppBar,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          SettingsItemListWidget(
            title: SettingsLabels.settingsBiometric,
            icon: Icons.fingerprint_rounded,
            trailing: TripleBuilder<UseBiometricsStore, Exception,
                UseBiometricPermission>(
              store: useBiometricsStore,
              builder: (_, triple) {
                return Platform.isIOS
                    ? CupertinoSwitch(
                        value: triple.state == UseBiometricPermission.accepted,
                        onChanged: (change) async {
                          LocalAuthService.authenticate().then(
                            (value) {
                              useBiometricsStore
                                  .changeBiometricPermission(change);
                            },
                          );
                        },
                      )
                    : Switch(
                        value: triple.state == UseBiometricPermission.accepted,
                        onChanged: (change) {
                          LocalAuthService.authenticate().then(
                            (value) {
                              useBiometricsStore
                                  .changeBiometricPermission(change);
                            },
                          );
                        },
                      );
              },
            ),
          ),
          const Divider(),
          SettingsItemListWidget(
            title: SettingsLabels.settingsNotification,
            icon: Icons.notifications_active_outlined,
            onTap: () {
              Permissions.openSettings();
            },
            showTrailingIcon: true,
          ),
          const Divider(),
          // SettingsItemListWidget(
          //   title: 'Token',
          //   icon: Icons.downloading_sharp,
          //   onTap: () async {
          //     await preferencesService.getUserID().then((user) async {
          //       await preferencesService
          //           .getUserPreferences(user!)
          //           .then((preference) async {
          //         preference.jwt!.token = 'testedetoken';
          //         await preferencesService.setUserPreferences(preference);
          //       });
          //     });
          //   },
          //   showTrailingIcon: true,
          // ),
        ],
      ),
    );
  }
}
