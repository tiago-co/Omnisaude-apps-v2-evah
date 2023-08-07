import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_devices_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/my_devices_store.dart';

class ConnectDeviceButtomWidget extends StatefulWidget {
  final MyDevicesStore myDevicesStore;
  const ConnectDeviceButtomWidget({
    Key? key,
    required this.myDevicesStore,
  }) : super(key: key);

  @override
  _ConnectDeviceButtomWidgetState createState() =>
      _ConnectDeviceButtomWidgetState();
}

class _ConnectDeviceButtomWidgetState extends State<ConnectDeviceButtomWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.060),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Stack(
                      children: [
                        SvgPicture.asset(
                          Assets.alertBluetoothBase,
                          package: AssetsPackage.omniCore,
                          height: 80.0,
                        ),
                        SvgPicture.asset(
                          Assets.alertBluetoothColor,
                          package: AssetsPackage.omniCore,
                          color: Theme.of(context).primaryColor,
                          height: 80.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Flexible(
                    flex: 7,
                    child: Text(
                      MyDevicesLabels.connectDeviceButtomConnectDevice,
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                height: 1.25,
                              ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Modular.to.popAndPushNamed(
                        'connect_device',
                        arguments: {
                          'myDevicesStore': widget.myDevicesStore,
                        },
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      padding: const EdgeInsets.all(7.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const SizedBox(width: 5.0),
                            Text(
                              MyDevicesLabels.connectDeviceButtomConnect,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                            const SizedBox(width: 15.0),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20.0,
                            ),
                            const SizedBox(width: 5.0),
                          ],
                        ),
                        // child: Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 10),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       const SizedBox(width: 10),
                        //       Text(
                        //         'Conectar Agora!',
                        //         style: Theme.of(context)
                        //             .textTheme
                        //             .headlineSmall!
                        //             .copyWith(
                        //               fontWeight: FontWeight.bold,
                        //               color: Theme.of(context)
                        //                   .colorScheme
                        //                   .background,
                        //             ),
                        //       ),
                        //       const Spacer(),
                        //       Icon(
                        //         Icons.arrow_forward,
                        //         color: Theme.of(context).colorScheme.background,
                        //         size: 20,
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
