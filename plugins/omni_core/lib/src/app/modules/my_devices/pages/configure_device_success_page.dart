import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:my_devices_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

class ConfigureDeviceSuccessPage extends StatelessWidget {
  const ConfigureDeviceSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: LayoutBuilder(
              builder: (_, constrains) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: constrains.maxWidth * 0.05,
                    ),
                    constraints: BoxConstraints(
                      minHeight: constrains.maxHeight,
                    ),
                    alignment: Alignment.center,
                    child: Center(
                      child: Column(
                        children: [
                          Lottie.asset(
                            Assets.check,
                            package: AssetsPackage.omniGeneral,
                            height: 200,
                          ),
                          const SizedBox(height: 15),
                          Text(
                            MyDevicesLabels.configureDeviceSuccessConnected,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          BottomButtonWidget(
            onPressed: () {
              Modular.to.popUntil(ModalRoute.withName('/home/'));
            },
            buttonType: BottomButtonType.outline,
            text: MyDevicesLabels.configureDeviceSuccessConclude,
          ),
        ],
      ),
    );
  }
}
