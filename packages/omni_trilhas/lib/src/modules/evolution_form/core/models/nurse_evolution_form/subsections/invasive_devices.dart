import 'package:omni_trilhas/src/modules/evolution_form/core/models/nurse_evolution_form/subsections/invasive_device_item_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/utils/utils.dart';

class InvasiveDevicesModel {
  String? id;
  InvasiveDeviceItemModel? centralVenousCatheter;
  InvasiveDeviceItemModel? doubleLumenHemodialysisCatheter;
  InvasiveDeviceItemModel? invasiveBloodPressure;
  InvasiveDeviceItemModel? peripheralVenousAccess;
  InvasiveDeviceItemModel? arteriovenousFistula;
  InvasiveDeviceItemModel? hypodermoclysis;
  InvasiveDeviceItemModel? picc;
  InvasiveDeviceItemModel? portToCath;
  String? observation;

  InvasiveDevicesModel({
    this.id,
    this.centralVenousCatheter,
    this.doubleLumenHemodialysisCatheter,
    this.invasiveBloodPressure,
    this.peripheralVenousAccess,
    this.arteriovenousFistula,
    this.hypodermoclysis,
    this.picc,
    this.portToCath,
    this.observation,
  });

  InvasiveDevicesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    centralVenousCatheter =
        InvasiveDeviceItemModel.fromJson(json['cateter_venoso_central']);
    doubleLumenHemodialysisCatheter = InvasiveDeviceItemModel.fromJson(
        json['cateter_duplo_lumen_hemodialise']);
    invasiveBloodPressure =
        InvasiveDeviceItemModel.fromJson(json['pressao_arterial_invasiva']);
    peripheralVenousAccess =
        InvasiveDeviceItemModel.fromJson(json['acesso_venoso_periferico']);
    arteriovenousFistula =
        InvasiveDeviceItemModel.fromJson(json['fistula_arteriovenosa']);
    hypodermoclysis = InvasiveDeviceItemModel.fromJson(json['hipodermoclise']);
    picc = InvasiveDeviceItemModel.fromJson(json['picc']);
    portToCath = InvasiveDeviceItemModel.fromJson(json['port_a_cath']);
    observation = json['observacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cateter_venoso_central'] = centralVenousCatheter?.toJson();
    data['cateter_duplo_lumen_hemodialise'] =
        doubleLumenHemodialysisCatheter?.toJson();
    data['pressao_arterial_invasiva'] = invasiveBloodPressure?.toJson();
    data['acesso_venoso_periferico'] = peripheralVenousAccess?.toJson();
    data['fistula_arteriovenosa'] = arteriovenousFistula?.toJson();
    data['hipodermoclise'] = hypodermoclysis?.toJson();
    data['picc'] = picc?.toJson();
    data['port_a_cath'] = portToCath?.toJson();
    data['observacao'] = observation;
    return data;
  }

  Map<String, dynamic> getData() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Observação'] = buildFieldMap(
      type: 'simple',
      value: observation,
    );
    data['Cateter Venoso Central'] = buildFieldMap(
      type: 'map',
      value: centralVenousCatheter?.getData(),
    );
    data['Cateter Duplo Lumen Hemodialise'] = buildFieldMap(
      type: 'map',
      value: doubleLumenHemodialysisCatheter?.getData(),
    );
    data['Pressão Arterial Invasiva'] = buildFieldMap(
      type: 'map',
      value: invasiveBloodPressure?.getData(),
    );
    data['Acesso Venoso Periferico'] = buildFieldMap(
      type: 'map',
      value: peripheralVenousAccess?.getData(),
    );
    data['Fistula Arteriovenosa'] = buildFieldMap(
      type: 'map',
      value: arteriovenousFistula?.getData(),
    );
    data['Hipodermoclise'] = buildFieldMap(
      type: 'map',
      value: hypodermoclysis?.getData(),
    );
    data['PICC'] = buildFieldMap(
      type: 'map',
      value: picc?.getData(),
    );
    data['Port a Cath'] = buildFieldMap(
      type: 'map',
      value: portToCath?.getData(),
    );

    return data;
  }
}
