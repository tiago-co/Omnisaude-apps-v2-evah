import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_drug_control_labels/labels.dart';

class NewDrugControlSuccess extends StatelessWidget {
  const NewDrugControlSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.height * 0.25,
            child: Stack(
              fit: StackFit.expand,
              children: [
                SvgPicture.asset(
                  Assets.successBase,
                  package: AssetsPackage.omniScheduling,
                ),
                SvgPicture.asset(
                  Assets.success,
                  color: Theme.of(context).primaryColor,
                  package: AssetsPackage.omniScheduling,
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Text(
            DrugControlLabels.newDrugControlCongratulations,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              DrugControlLabels.newDrugControlSuccess,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ],
      ),
    );
  }
}
