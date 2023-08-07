import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/procedure_model.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/procedures/pages/widgets/procedure_item_shimmer_widget.dart';
import 'package:omni_core/src/app/modules/procedures/pages/widgets/procedure_item_widget.dart';
import 'package:omni_core/src/app/modules/procedures/pages/widgets/procedures_date_filter_widget.dart';
import 'package:omni_core/src/app/modules/procedures/stores/procedures_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:procedures_labels/labels.dart';

class ProceduresPage extends StatefulWidget {
  final String moduleName;
  const ProceduresPage({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  @override
  _ProceduresPageState createState() => _ProceduresPageState();
}

class _ProceduresPageState extends State<ProceduresPage> {
  final ProceduresStore store = Modular.get();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    final DateTime now = DateTime.now();
    store.params.limit = '10';
    store.params.startDate = Formaters.dateToStringDate(
      DateTime(now.year, now.month),
    );
    store.params.endDate = Formaters.dateToStringDate(
      DateTime(now.year, now.month + 1, 0),
    );
    store.getProcedures(store.params);

    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.state.results.length != store.state.count) {
        store.params.limit = (int.parse(store.params.limit!) + 10).toString();
        store.getProcedures(store.params);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName).build(context) as AppBar,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ColoredBox(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: ProceduresDateFilterWidget(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFieldWidget(
                  label: ProceduresLabels.proceduresLabel,
                  placeholder: ProceduresLabels.proceduresPlaceholder,
                  controller: textController,
                  onChange: (String? input) {
                    store.getProceduresParams(input, store.params);
                  },
                  suffixIcon: SvgPicture.asset(
                    Assets.search,
                    package: AssetsPackage.omniGeneral,
                  ),
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
                      store.getProcedures(store.params);
                    },
                    child: _buildProceduresListWidget,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomButtonWidget(
        onPressed: () {
          Modular.to.pushNamed(
            'crisisDiary',
            arguments: ProceduresLabels.proceduresCrisisDiary,
          );
        },
        buttonType: BottomButtonType.outline,
        isDisabled: !store.programStore.programSelected.activeImplant,
        text: ProceduresLabels.proceduresCrisisDiary,
      ),
    );
  }

  Widget get _buildProceduresListWidget {
    return TripleBuilder<ProceduresStore, DioError, ProcedureResultsModel>(
      store: store,
      builder: (_, triple) {
        Widget loading = const SizedBox();
        if (triple.isLoading) {
          loading = const ProcedureItemShimmerWidget();
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
                      onPressed: () => store.getProcedures(store.params),
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
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: EmptyWidget(
                    message: ProceduresLabels.procedureEmpty,
                    textButton: ProceduresLabels.tryAgain,
                    onPressed: () {
                      store.getProcedures(store.params);
                    },
                  ),
                ),
              ),
            if (triple.state.results.isNotEmpty)
              Scrollbar(
                controller: scrollController,
                child: ListView.builder(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: triple.state.results.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  itemBuilder: (_, index) {
                    return ProcedureItemWidget(
                      procedure: triple.state.results[index],
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
