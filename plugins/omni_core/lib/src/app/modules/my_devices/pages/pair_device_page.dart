import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:my_devices_labels/labels.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/my_devices/model/my_devices_model.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/my_devices_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/omni_measurement.dart';

class PairDevicePage extends StatefulWidget {
  final MyDevicesStore myDevicesStore;

  final BluetoothDevice connectedDevice;
  const PairDevicePage({
    Key? key,
    required this.connectedDevice,
    required this.myDevicesStore,
  }) : super(key: key);

  @override
  _PairDevicePageState createState() => _PairDevicePageState();
}

class _PairDevicePageState extends State<PairDevicePage> {
  final UserStore userStore = Modular.get<UserStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: MyDevicesLabels.pairDeviceTitle,
      ).build(context) as AppBar,
      body: TripleBuilder<MyDevicesStore, Exception, MyDeviceModel>(
        store: widget.myDevicesStore,
        builder: (_, triple) {
          if (!triple.isLoading && widget.myDevicesStore.state.isPaired!) {
            // widget.myDevicesStore.addDeviceToList(widget.connectedDevice);
            Modular.to.pushNamed('success_page');
          }
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  MyDevicesLabels.pairDeviceFound,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const SizedBox(height: 20.0),
                Image.asset(
                  widget.myDevicesStore.state.measurementType!.typeDevice[0]
                      .asset,
                  package: AssetsPackage.omniMeasurement,
                  width: 220,
                  height: 220,
                ),
                Text(
                  '''
${MyDevicesLabels.pairDeviceVerifyCode} ${widget.connectedDevice.name}''',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    widget.myDevicesStore
                        .pairDevice(widget.connectedDevice)
                        .then((value) {})
                        .catchError((onError) {
                      Helpers.showDialog(context, onError);
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.all(15.0),
                    width: double.infinity,
                    child: widget.myDevicesStore.isPairing
                        ? const LoadingWidget()
                        : Text(
                            MyDevicesLabels.pairDeviceInsertPin,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
