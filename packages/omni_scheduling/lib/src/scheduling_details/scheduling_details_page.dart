import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_status_enum.dart';

import 'package:omni_scheduling/src/scheduling_details/stores/scheduling_details_store.dart';
import 'package:omni_scheduling/src/scheduling_details/widgets/scheduling_details_actions_shimmer_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/widgets/scheduling_details_actions_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/widgets/scheduling_details_field_shimmer_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/widgets/scheduling_details_field_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/widgets/scheduling_details_header_shimmer_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/widgets/scheduling_details_header_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/widgets/scheduling_details_rescheduling_widget.dart';
import 'package:omni_scheduling/src/scheduling_details/widgets/scheduling_details_type_widget.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingDetailsPage extends StatefulWidget {
  final String attendanceType;
  final String schedulingId;
  final String beneficiaryId;

  const SchedulingDetailsPage({
    Key? key,
    required this.attendanceType,
    required this.schedulingId,
    required this.beneficiaryId,
  }) : super(key: key);

  @override
  _SchedulingDetailsPageState createState() => _SchedulingDetailsPageState();
}

class _SchedulingDetailsPageState extends State<SchedulingDetailsPage> {
  final SchedulingDetailsStore store = Modular.get();
  @override
  void initState() {
    store.getSchedulingById(widget.schedulingId).then((_) {
      store.professionalStore.getProfessionalStatus(store.state);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: TripleBuilder(
          store: store,
          builder: (_, triple) {
            return NavBarWidget(
              title: widget.attendanceType,
              argsCallback: store.state,
            );
          },
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TripleBuilder(
              store: store,
              builder: (_, triple) {
                if (triple.isLoading) {
                  return const SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: SafeArea(
                      child: SchedulingDetailsHeaderShimmerWidget(),
                    ),
                  );
                }
                return _buildSchedulingHeaderWidget;
              },
            ),
          ),
          Expanded(
            child: Theme(
              data: Theme.of(context).copyWith(
                shadowColor: Colors.transparent,
              ),
              child: RefreshIndicator(
                displacement: 0,
                strokeWidth: 0.75,
                color: Theme.of(context).primaryColor,
                backgroundColor: Theme.of(context).colorScheme.background,
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                onRefresh: () async {
                  store.getSchedulingById(store.state.id!).then((_) {
                    store.professionalStore.getProfessionalStatus(store.state);
                  });
                },
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        child: SafeArea(child: _buildScrollableWidget),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildSchedulingHeaderWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 15),
        SchedulingDetailsHeaderWidget(scheduling: store.state),
        const Divider(height: 30),
        SchedulingDetailsTypeWidget(
          scheduling: store.state,
          typeScheduling: widget.attendanceType,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget get _buildScrollableWidget {
    return TripleBuilder(
      store: store,
      builder: (_, triple) {
        if (triple.isLoading) {
          return Column(
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: SchedulingDetailsFieldShimmerWidget(),
              ),
              SizedBox(height: 15),
              SchedulingDetailsActionsShimmerWidget(),
            ],
          );
        }
        return _buildSchedulingDetailsWidget;
      },
    );
  }

  Widget get _buildSchedulingDetailsWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (store.state.status == SchedulingStatus.onApproval)
                SchedulingDetailsReschedulingWidget(
                  scheduling: store.state,
                  beneficiaryId: widget.beneficiaryId,
                ),
              SchedulingDetailsFieldWidget(
                label: SchedulingLabels.schedulingDetailsStatus,
                value: store.state.status?.label ??
                    SchedulingLabels.schedulingDetailsEmptyStatus,
              ),
              SchedulingDetailsFieldWidget(
                label: SchedulingLabels.schedulingDetailsDate,
                value: Formaters.dateToStringDate(
                  Formaters.stringToDateTime(
                    store.state.startDate!,
                  ),
                ),
              ),
              SchedulingDetailsFieldWidget(
                label: SchedulingLabels.schedulingDetailsHour,
                value: Formaters.dateToStringTime(
                  Formaters.stringToDateTime(
                    store.state.startDate!,
                  ),
                ),
              ),
              SchedulingDetailsFieldWidget(
                label: SchedulingLabels.schedulingDetailsReason,
                value: store.state.reason ??
                    SchedulingLabels.schedulingDetailsUninformed,
                showAll: true,
              ),
              if (store.state.status == SchedulingStatus.canceled)
                SchedulingDetailsFieldWidget(
                  label: SchedulingLabels.schedulingDetailsCancelReason,
                  value: store.state.cancelReason ??
                      SchedulingLabels.schedulingDetailsUninformed,
                  showAll: true,
                ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        SchedulingDetailsActionsWidget(scheduling: store.state),
      ],
    );
  }
}
