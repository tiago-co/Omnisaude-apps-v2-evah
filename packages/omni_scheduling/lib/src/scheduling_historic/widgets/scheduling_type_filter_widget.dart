import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_type_filter_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingTypeFilterWidget extends StatefulWidget {
  const SchedulingTypeFilterWidget({Key? key}) : super(key: key);

  @override
  _SchedulingTypeFilterWidgetState createState() =>
      _SchedulingTypeFilterWidgetState();
}

class _SchedulingTypeFilterWidgetState
    extends State<SchedulingTypeFilterWidget> {
  final SchedulingTypeFilterStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
      store: store.historicStore,
      builder: (_, triple) {
        return Opacity(
          opacity: triple.isLoading ? 0.5 : 1.0,
          child: CupertinoSlidingSegmentedControl(
            children: {
              0: _buildSchedulingType(
                SchedulingLabels.schedulingTypeFilterAll,
                store.state == 0,
              ),
              1: _buildSchedulingType(
                SchedulingLabels.schedulingTypeFilterPresential,
                store.state == 1,
              ),
              2: _buildSchedulingType(
                SchedulingLabels.schedulingTypeFilterTeleattendence,
                store.state == 2,
              ),
            },
            groupValue: store.state,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(
                  0.1,
                ),
            thumbColor: Theme.of(context).primaryColor,
            onValueChanged:
                triple.isLoading ? (int? value) => value : store.onValueChanged,
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
