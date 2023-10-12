import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_switch/flutter_switch.dart';

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool active = true;
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
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Card(
                        elevation: 0,
                        color: const Color(0xfff6f6f8),
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
                                'Touch ID',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 1.6000000238,
                                  color: const Color(0xff1a1c22),
                                ),
                              ),
                              FlutterSwitch(
                                value: active,
                                activeToggleColor: Colors.white,
                                activeColor: const Color(0xff06C270),
                                height: 25,
                                width: 48,
                                padding: 2.5,
                                onToggle: (value) {
                                  setState(() {
                                    active = !active;
                                  });
                                },
                              ),
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
