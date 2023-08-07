import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/core/models/vaccine_model.dart';
import 'package:omni_core/src/app/modules/vaccine/vaccine_store.dart';
import 'package:vaccine_labels/labels.dart';

class VaccineCardDetailsWidget extends StatefulWidget {
  final VaccineModel vaccineModel;

  const VaccineCardDetailsWidget({Key? key, required this.vaccineModel})
      : super(key: key);

  @override
  _VaccineCardDetailsWidgetState createState() =>
      _VaccineCardDetailsWidgetState();
}

class _VaccineCardDetailsWidgetState extends State<VaccineCardDetailsWidget> {
  final VaccineStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Theme.of(context).cardColor.withOpacity(0.25),
          ),
        ),
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 7,
              child: RotatedBox(
                quarterTurns: 3,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        '${widget.vaccineModel.dose!} ${VaccineLabels.vaccineCardDetailDose}'
                            .toUpperCase(),
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 90,
              child: Container(
                margin: EdgeInsets.zero,
                color: Colors.white,
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(15),
                          height: 20,
                          width: 3,
                          color: Colors.green,
                        ),
                        Text(
                          widget.vaccineModel.name!.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                VaccineLabels.vaccineCardDetailsDate,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.vaccineModel.date!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                VaccineLabels.vaccineCardDetailsLaboraty,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.vaccineModel.laboraty!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                VaccineLabels.vaccineCardDetailsLot,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.vaccineModel.lot!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 15,
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                VaccineLabels.vaccineCardDetailsVaccination,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.vaccineModel.vaccination!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        bottom: 15,
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                VaccineLabels.vaccineCardDetailsProfessional,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                widget.vaccineModel.professional!,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: 12,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
