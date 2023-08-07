import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_historic_store.dart';
import 'package:omni_scheduling/src/scheduling_historic/widgets/scheduling_professional_filter_widget.dart';
import 'package:omni_scheduling/src/scheduling_historic/widgets/scheduling_specialty_filter_widget.dart';
import 'package:omni_scheduling/src/scheduling_historic/widgets/scheduling_status_filter_widget.dart';

class SchedulingGeneralFiltersWidget extends StatefulWidget {
  const SchedulingGeneralFiltersWidget({Key? key}) : super(key: key);

  @override
  _SchedulingGeneralFiltersWidgetState createState() =>
      _SchedulingGeneralFiltersWidgetState();
}

class _SchedulingGeneralFiltersWidgetState
    extends State<SchedulingGeneralFiltersWidget> {
  final SchedulingHistoricStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        return AbsorbPointer(
          absorbing: triple.isLoading,
          child: Opacity(
            opacity: triple.isLoading ? 0.5 : 1.0,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  SchedulingProfessionalFilterWidget(),
                  SizedBox(width: 10),
                  SchedulingStatusFilterWidget(),
                  SizedBox(width: 10),
                  SchedulingSpecialtyFilterWidget(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
