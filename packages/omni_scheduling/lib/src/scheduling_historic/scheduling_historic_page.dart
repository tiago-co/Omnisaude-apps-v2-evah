import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/omni_scheduling.dart';
import 'package:omni_scheduling/src/scheduling_historic/stores/scheduling_historic_store.dart';
import 'package:omni_scheduling/src/scheduling_historic/widgets/scheduling_date_filter_widget.dart';
import 'package:omni_scheduling/src/scheduling_historic/widgets/scheduling_general_filters_widget.dart';
import 'package:omni_scheduling/src/scheduling_historic/widgets/scheduling_item_shimmer_widget.dart';
import 'package:omni_scheduling/src/scheduling_historic/widgets/scheduling_item_widget.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingHistoricPage extends StatefulWidget {
  final String moduleName;
  final String beneficiaryId;
  final SchedulingType schedulingType;
  final SchedulingModeModel schedulingModeModel;

  const SchedulingHistoricPage({
    Key? key,
    required this.moduleName,
    required this.beneficiaryId,
    required this.schedulingType,
    required this.schedulingModeModel,
  }) : super(key: key);

  @override
  _SchedulingHistoricPageState createState() => _SchedulingHistoricPageState();
}

class _SchedulingHistoricPageState extends State<SchedulingHistoricPage> {
  final SchedulingHistoricStore store = Modular.get();
  final ScrollController scrollController = ScrollController();
  final UserStore userStore = Modular.get();

  @override
  void initState() {
    store.params.limit = '10';
    store.params.type = widget.schedulingType.toJson;
    store.getSchedules(store.params);

    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.state.results.length != store.state.count) {
        store.params.limit = (int.parse(store.params.limit!) + 10).toString();
        store.getSchedules(store.params);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName).build(context) as AppBar,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TripleBuilder(
              store: store,
              builder: (_, triple) {
                return AbsorbPointer(
                  absorbing: triple.isLoading,
                  child: const SchedulingDateFilterWidget(),
                );
              },
            ),
          ),
          const SchedulingGeneralFiltersWidget(),
          const SizedBox(height: 10),
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
                  store.getSchedules(store.params);
                },
                child: _buildSchedulesListWidget,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: TripleBuilder<SchedulingHistoricStore, DioError,
          SchedulingResultsModel>(
        store: store,
        builder: (_, triple) {
          return BottomButtonWidget(
            isDisabled: triple.isLoading,
            buttonType: BottomButtonType.outline,
            onPressed: () => Modular.to.pushNamed(
              '/home/schedulings/newScheduling',
              arguments: {
                'moduleName': 'Novo Agendamento',
                'schedulingType': widget.schedulingType,
                'beneficiaryId': userStore.state.jwt!.id,
                'schedulingMode': widget.schedulingModeModel,
              },
            ),
            text:
                '${SchedulingLabels.schedulingHistoricNew} ${widget.moduleName}',
          );
        },
      ),
    );
  }

  Widget get _buildSchedulesListWidget {
    return TripleBuilder<SchedulingHistoricStore, DioError,
        SchedulingResultsModel>(
      store: store,
      builder: (_, triple) {
        Widget loading = const SizedBox();
        if (triple.isLoading) {
          loading = const SchedulingItemShimmerWidget();
        }
        if (triple.event == TripleEvent.error) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    clipBehavior: Clip.antiAlias,
                    physics: const BouncingScrollPhysics(),
                    child: RequestErrorWidget(
                      error: triple.error,
                      onPressed: () => store.getSchedules(store.params),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Stack(
          fit: StackFit.expand,
          children: [
            if (triple.state.results.isEmpty && !triple.isLoading)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: EmptyWidget(
                    message: SchedulingLabels.schedulingHistoricEmpty,
                    textButton: SchedulingLabels.schedulingHistoricShearchAgain,
                    onPressed: () => store.getSchedules(store.params),
                  ),
                ),
              ),
            if (triple.state.results.isNotEmpty)
              Scrollbar(
                controller: scrollController,
                child: ListView.builder(
                  itemCount: triple.state.results.length,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  controller: scrollController,
                  itemBuilder: (_, index) {
                    return SafeArea(
                      bottom: triple.state.results.last ==
                          triple.state.results[index],
                      child: SchedulingItemWidget(
                        scheduling: triple.state.results[index],
                        beneficiaryId: widget.beneficiaryId,
                        typeScheduling: widget.moduleName,
                      ),
                    );
                  },
                ),
              ),
            loading,
          ],
        );
      },
    );
  }
}
