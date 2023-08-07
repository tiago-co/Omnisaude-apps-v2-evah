import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_mediktor/src/core/models/mediktor_diagnosis_model.dart';
import 'package:omni_mediktor/src/mediktor_diagnosis/pages/mediktor_diagnosis_page.dart';

import 'package:omni_mediktor/src/mediktor_historic/stores/mediktor_historic_store.dart';
import 'package:omni_mediktor/src/mediktor_historic/widgets/mediktor_historic_date_filter_widget.dart';
import 'package:omni_mediktor/src/mediktor_historic/widgets/mediktor_historic_item_shimmer_widget.dart';
import 'package:omni_mediktor/src/mediktor_historic/widgets/mediktor_historic_item_widget.dart';

class MediktorHistoricPage extends StatefulWidget {
  final String moduleName;

  const MediktorHistoricPage({
    Key? key,
    required this.moduleName,
  }) : super(key: key);
  @override
  MediktorHistoricPageState createState() => MediktorHistoricPageState();
}

class MediktorHistoricPageState extends State<MediktorHistoricPage> {
  final MediktorHistoricStore store = Modular.get();
  final ScrollController scrollController = ScrollController();
  int _index = 0;

  @override
  void initState() {
    store.getDiagnosis();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _index,
      children: [
        Scaffold(
          appBar:
              NavBarWidget(title: widget.moduleName).build(context) as AppBar,
          body: Column(
            children: [
              const MediktorHistoricDateFilterWidget(),
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
                      store.getDiagnosis();
                    },
                    child: _buildDiagnosisListWidget,
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: TripleBuilder<MediktorHistoricStore, DioError,
              List<MediktorDiagnosisModel>>(
            store: store,
            builder: (_, triple) {
              return BottomButtonWidget(
                isDisabled: triple.isLoading,
                buttonType: BottomButtonType.outline,
                onPressed: () {
                  setState(
                    () {
                      _index = 1;
                    },
                  );
                },
                text: 'Novo Diagnóstico',
              );
            },
          ),
        ),
        const MediktorDiagnosisPage(moduleName: 'Novo Diagnóstico'),
      ],
    );
  }

  Widget get _buildDiagnosisListWidget {
    return TripleBuilder<MediktorHistoricStore, DioError,
        List<MediktorDiagnosisModel>>(
      store: store,
      builder: (_, triple) {
        Widget loading = const SizedBox();
        if (triple.isLoading) {
          loading = const MediktorHistoricItemShimmerWidget();
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
                      onPressed: () => store.getDiagnosis(),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        return Stack(
          children: [
            if (triple.state.isEmpty && !triple.isLoading)
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        clipBehavior: Clip.antiAlias,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        physics: const BouncingScrollPhysics(),
                        child: EmptyWidget(
                          message: 'Nenhum diagnóstico encontrado!',
                          textButton: 'Tentar novamente',
                          onPressed: () => store.getDiagnosis(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (triple.state.isNotEmpty)
              Scrollbar(
                controller: scrollController,
                child: ListView.builder(
                  itemCount: triple.state.length,
                  controller: scrollController,
                  padding: const EdgeInsets.all(15),
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemBuilder: (_, index) {
                    return SafeArea(
                      bottom: triple.state.length - 1 == index,
                      child: AbsorbPointer(
                        absorbing: triple.state[index].urgency == null,
                        child: Opacity(
                          opacity:
                              triple.state[index].urgency == null ? 0.5 : 1,
                          child: MediktorHistoricItemWidget(
                            diagnose: triple.state[index],
                          ),
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
