import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/new_settings/stores/settings_store.dart';
import 'package:omni_general/omni_general.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool active = true;
  final SettingsStore store = Modular.get();
  final UseBiometricsStore useBiometricsStore = Modular.get();
  final PreferencesService preferencesService = PreferencesService();

  _getBiometrics() async {
    final hasBiometrics = await useBiometricsStore.getHasBiometrics();
    useBiometricsStore.updateState(hasBiometrics);
  }

  @override
  void initState() {
    super.initState();
    _getBiometrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        ),
        centerTitle: true,
        title: const Text(
          'Configurações',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: double.infinity,
            child: Container(
              // settingsTGT (5103:24901)
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Card(
                        elevation: 0,
                        color: const Color(0xffF6F6F8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 16,
                          ),
                          child:
                              //  SizedBox(
                              //   height: 26,
                              //   child: SwitchListTile(
                              //     title: const Text(
                              //       'Touch ID',
                              //       style: TextStyle(
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.w500,
                              //         height: 1.6000000238,
                              //         color: const Color(0xff1a1c22),
                              //       ),
                              //     ),
                              //     value: active,
                              //     activeColor: Colors.white,
                              //     activeTrackColor: const Color(0xff06C270),
                              //     materialTapTargetSize:
                              //         MaterialTapTargetSize.shrinkWrap,
                              //     visualDensity: VisualDensity.comfortable,
                              //     contentPadding: EdgeInsets.zero,
                              //     onChanged: (value) {
                              //       setState(() {
                              //         active = value;
                              //       });
                              //     },
                              //   ),
                              Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Biometria',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 1.6000000238,
                                  color: const Color(0xff1a1c22),
                                ),
                              ),
                              TripleBuilder<UseBiometricsStore, Exception, UseBiometricPermission>(
                                  store: useBiometricsStore,
                                  builder: (_, triple) {
                                    return FlutterSwitch(
                                      value: triple.state == UseBiometricPermission.accepted,
                                      activeToggleColor: Colors.white,
                                      activeColor: const Color(0xff06C270),
                                      height: 25,
                                      width: 48,
                                      padding: 2.5,
                                      onToggle: (change) async {
                                        await useBiometricsStore.canAuthenticateUser();
                                        if (useBiometricsStore.canUseBiometricAuth &&
                                                useBiometricsStore.state == UseBiometricPermission.notAccepted ||
                                            useBiometricsStore.state == UseBiometricPermission.accepted) {
                                          LocalAuthService.authenticate().then(
                                            (value) {
                                              useBiometricsStore.changeBiometricPermission(change);
                                            },
                                          );
                                        }
                                      },
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
