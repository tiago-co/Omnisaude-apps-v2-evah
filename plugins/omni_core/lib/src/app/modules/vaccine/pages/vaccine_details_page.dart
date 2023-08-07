import 'package:flutter/material.dart';
import 'package:omni_core/src/app/core/models/vaccine_model.dart';
import 'package:omni_core/src/app/modules/vaccine/widgets/vaccine_card_details_widget.dart';
import 'package:omni_general/omni_general.dart';

class VaccineDetailsPage extends StatefulWidget {
  final VaccineModel vaccineModel;
  const VaccineDetailsPage({
    Key? key,
    required this.vaccineModel,
  }) : super(
          key: key,
        );

  @override
  _VaccineDetailsPageState createState() => _VaccineDetailsPageState();
}

class _VaccineDetailsPageState extends State<VaccineDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(
        title: widget.vaccineModel.category!.name!,
      ).build(context) as AppBar,
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: 1,
        itemBuilder: (_, index) => VaccineCardDetailsWidget(
          vaccineModel: widget.vaccineModel,
        ),
      ),
    );
  }
}
