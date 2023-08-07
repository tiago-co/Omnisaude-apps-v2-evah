import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/vaccine/vaccine_store.dart';
import 'package:omni_core/src/app/modules/vaccine/widgets/vaccine_list_category_widget.dart';
import 'package:omni_general/omni_general.dart';

class VaccinePage extends StatefulWidget {
  final String moduleName;

  const VaccinePage({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  @override
  _VaccinePageState createState() => _VaccinePageState();
}

class _VaccinePageState extends State<VaccinePage> {
  final VaccineStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName).build(context) as AppBar,
      body: const VaccineListCategoryWidget(),
    );
  }
}
