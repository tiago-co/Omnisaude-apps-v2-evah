import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_drug_control/src/core/models/drug_control_model.dart';
import 'package:omni_drug_control/src/drug_control_historic/pages/medicine_historic_page.dart';
import 'package:omni_drug_control/src/drug_control_historic/pages/widgets/drug_control_historic_item_widget.dart';
import 'package:omni_drug_control/src/drug_control_historic/pages/widgets/drug_control_type_filter_widget.dart';
import 'package:omni_drug_control/src/drug_control_historic/pages/widgets/historic_item_shimmer_widget.dart';
import 'package:omni_drug_control/src/drug_control_historic/stores/drug_control_historic_store.dart';
import 'package:omni_drug_control_labels/labels.dart';
import 'package:omni_general/omni_general.dart';

class DrugControlHistoricPage extends StatefulWidget {
  final String moduleName;
  final ProgramModel program;

  const DrugControlHistoricPage({
    Key? key,
    required this.moduleName,
    required this.program,
  }) : super(key: key);

  @override
  _DrugControlHistoricPageState createState() =>
      _DrugControlHistoricPageState();
}

class _DrugControlHistoricPageState extends State<DrugControlHistoricPage> {
  final DrugControlHistoricStore store = Modular.get();
  final GlobalKey medicineKey = GlobalKey();
  final UserStore userStore = Modular.get();
  final PageController pageController = PageController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    store.params.limit = '10';
    store.getDrugControls(store.params);

    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.state.results!.length != store.state.count) {
        store.params.limit = (int.parse(store.params.limit!) + 10).toString();
        store.getDrugControls(store.params);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
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
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: DrugControlTypeFilterWidget(
              pageController: pageController,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildDrugControlHistoricWidget,
                  MedicineHistoricPage(key: medicineKey),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: TripleBuilder<DrugControlHistoricStore, DioError,
          DrugControlResultsModel>(
        store: store,
        builder: (_, triple) {
          return BottomButtonWidget(
            isDisabled: triple.isLoading,
            buttonType: BottomButtonType.outline,
            onPressed: () => Modular.to.pushNamed(
              '/home/drugControl/newDrugControl',
              arguments: {
                'moduleName': 'Controle Medicamentoso',
                'program': userStore.programSelected,
                'useCaregiver': userStore.oprConfigs.useCaregiver,
                'useCustomMedication': userStore.oprConfigs.useCustomMedication,
              },
            ),
            text: DrugControlLabels.drugControlHistoricNewControl,
          );
        },
      ),
    );
  }

  Widget get _buildDrugControlHistoricWidget {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: TextFieldWidget(
            label: DrugControlLabels.drugControlHistoricDrugControlLabel,
            placeholder:
                DrugControlLabels.drugControlHistoricDrugControlPlaceholder,
            controller: TextEditingController(),
            onChange: store.getDrugControlsParams,
          ),
        ),
        const SizedBox(height: 5),
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
                store.getDrugControls(store.params);
              },
              child: _buildDrugControlListWidget,
            ),
          ),
        ),
      ],
    );
  }

  Widget get _buildDrugControlListWidget {
    return TripleBuilder<DrugControlHistoricStore, DioError,
        DrugControlResultsModel>(
      store: store,
      builder: (_, triple) {
        Widget loading = const SizedBox();
        if (triple.isLoading) {
          loading = const HistoricItemShimmerWidget();
        }

        if (triple.event == TripleEvent.error) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: RequestErrorWidget(
                      error: triple.error,
                      onPressed: () => store.getDrugControls(store.params),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Stack(
          children: [
            if (triple.state.results!.isEmpty && !triple.isLoading)
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        clipBehavior: Clip.antiAlias,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        physics: const BouncingScrollPhysics(),
                        child: EmptyWidget(
                          message:
                              DrugControlLabels.drugControlHistoricEmptyList,
                          textButton: DrugControlLabels.tryAgain,
                          onPressed: () => store.getDrugControls(store.params),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (triple.state.results!.isNotEmpty)
              Scrollbar(
                controller: scrollController,
                child: ListView.builder(
                  itemCount: triple.state.results!.length,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  itemBuilder: (_, index) {
                    return SafeArea(
                      bottom: triple.state.results!.last ==
                          triple.state.results![index],
                      child: VerticalTimelineItemWidget(
                        child: DrugControlHistoricItemWidget(
                          drugControl: triple.state.results![index],
                        ),
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
