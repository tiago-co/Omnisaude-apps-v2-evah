import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:my_devices_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/modules/my_devices/pages/widgets/device_type_widget.dart';
import 'package:omni_core/src/app/modules/my_devices/stores/my_devices_store.dart';
import 'package:omni_measurement/omni_measurement.dart';

class MeasurementTypePage extends StatefulWidget {
  const MeasurementTypePage({
    Key? key,
  }) : super(key: key);

  @override
  _MeasurementTypePageState createState() => _MeasurementTypePageState();
}

class _MeasurementTypePageState extends State<MeasurementTypePage> {
  final MyDevicesStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        shadowColor: Colors.transparent,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TypeDeviceMeasure(
                onTap: () {
                  store.state.measurementType = MeasurementType.oxygen;
                  Modular.to.pushNamed(
                    'device_model',
                    arguments: {
                      'myDevicesStore': store,
                    },
                  );
                },
                title: MyDevicesLabels.measurementTypeOximeter,
                asset: Assets.oximeterIcon,
                package: AssetsPackage.omniMeasurement,
                isImage: false,
              ),
              const Divider(),
              TypeDeviceMeasure(
                onTap: () {
                  store.state.measurementType = MeasurementType.glucose;

                  Modular.to.pushNamed(
                    'device_model',
                    arguments: {
                      'myDevicesStore': store,
                    },
                  );
                },
                title: MyDevicesLabels.measurementTypeGlucose,
                asset: Assets.glucoseIcon,
                package: AssetsPackage.omniMeasurement,
                isImage: false,
              ),
              const Divider(),
              TypeDeviceMeasure(
                onTap: () {
                  store.state.measurementType = MeasurementType.pressure;

                  Modular.to.pushNamed(
                    'device_model',
                    arguments: {
                      'myDevicesStore': store,
                    },
                  );
                },
                title: MyDevicesLabels.measurementTypeBloodPresure,
                asset: Assets.bloodPressureIcon,
                package: AssetsPackage.omniMeasurement,
                isImage: false,
              ),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
