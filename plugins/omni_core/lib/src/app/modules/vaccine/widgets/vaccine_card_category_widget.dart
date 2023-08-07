import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/core/models/vaccine_model.dart';

class VaccineCardCategoryWidget extends StatefulWidget {
  final VaccineModel vaccineModel;
  const VaccineCardCategoryWidget({
    Key? key,
    required this.vaccineModel,
  }) : super(
          key: key,
        );

  @override
  _VaccineCardCategoryWidgetState createState() =>
      _VaccineCardCategoryWidgetState();
}

class _VaccineCardCategoryWidgetState extends State<VaccineCardCategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: 80,
          width: MediaQuery.of(context).size.width * 95 / 100,
          child: GestureDetector(
            onTap: () {
              Modular.to.pushNamed(
                'vaccine_details',
                arguments: widget.vaccineModel,
              );
            },
            child: Card(
              color: Colors.white,
              elevation: 0,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: Theme.of(context).cardColor.withOpacity(0.25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.10),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: SvgPicture.asset(
                            Assets.vaccineOne,
                            package: AssetsPackage.omniCore,
                            width: 35,
                            height: 35,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          widget.vaccineModel.category!.name!,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
