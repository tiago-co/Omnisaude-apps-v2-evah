import 'package:diseases/src/modules/diseases/stores/disease_type_filter_store.dart';
import 'package:diseases_labels/labels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

class DiseaseTypeFilterWidget extends StatefulWidget {
  final PageController pageController;
  const DiseaseTypeFilterWidget({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<DiseaseTypeFilterWidget> createState() =>
      _DiseaseTypeFilterWidgetState();
}

class _DiseaseTypeFilterWidgetState extends State<DiseaseTypeFilterWidget> {
  final DiseaseTypeFilterStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        return Opacity(
          opacity: triple.isLoading ? 0.5 : 1.0,
          child: CupertinoSlidingSegmentedControl(
            children: {
              0: _buildSchedulingType(
                  DiseasesLabels.diseasesDiseases, store.state == 0),
              1: _buildSchedulingType(
                  DiseasesLabels.diseasesAllergies, store.state == 1),
            },
            groupValue: store.state,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(
                  0.1,
                ),
            thumbColor: Theme.of(context).primaryColor,
            onValueChanged: triple.isLoading
                ? (int? tab) => tab
                : (int? tab) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    widget.pageController.animateToPage(
                      tab ?? 0,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.decelerate,
                    );
                    store.updateStore(tab ?? 0);
                  },
          ),
        );
      },
    );
  }

  Widget _buildSchedulingType(String label, bool isActive) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      scrollDirection: Axis.horizontal,
      child: Tooltip(
        message: label,
        child: Text(
          label,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: isActive ? Colors.white : Theme.of(context).primaryColor,
                fontWeight: isActive ? FontWeight.w600 : null,
              ),
        ),
      ),
    );
  }
}
