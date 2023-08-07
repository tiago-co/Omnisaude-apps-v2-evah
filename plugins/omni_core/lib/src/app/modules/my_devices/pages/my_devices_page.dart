import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_devices_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/modules/my_devices/pages/measurement_type_page.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/my_devices_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_measurement/omni_measurement.dart';

class MyConnectionsPage extends StatefulWidget {
  final String title;
  final MeasurementType? measurementType;

  const MyConnectionsPage({
    Key? key,
    this.title = 'AboutPage',
    this.measurementType,
  }) : super(key: key);
  @override
  MyConnectionsPageState createState() => MyConnectionsPageState();
}

class MyConnectionsPageState extends State<MyConnectionsPage> {
  final MyDevicesStore store = Modular.get();
  @override
  void initState() {
    if (widget.measurementType != null) {
      store.state.measurementType = widget.measurementType;

      Modular.to.pushNamed(
        'device_model',
        arguments: {
          'myDevicesStore': store,
        },
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: MyDevicesLabels.myDevicesTitle,
      ).build(context) as AppBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: Stack(
                children: [
                  SvgPicture.asset(
                    Assets.myDeviceThree,
                    package: AssetsPackage.omniCore,
                  ),
                  SvgPicture.asset(
                    Assets.myDeviceTwo,
                    color: Theme.of(context).primaryColor,
                    package: AssetsPackage.omniCore,
                  ),
                  SvgPicture.asset(
                    Assets.myDeviceOne,
                    package: AssetsPackage.omniCore,
                  ),
                ],
              ),
            ),
            Text(
              MyDevicesLabels.myDevicesManagement,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const Expanded(
              child: MeasurementTypePage(),
            ),
          ],
        ),
      ),
    );
  }
}
