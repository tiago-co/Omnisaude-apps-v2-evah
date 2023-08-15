import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_assistance/src/assistance/stores/assistance_store.dart';
import 'package:omni_assistance/src/assistance/stores/assistances_store.dart';
import 'package:omni_assistance/src/assistance/widgets/assistance_general_filters_widget.dart';
import 'package:omni_assistance/src/core/enums/assistance_status_enum.dart';
import 'package:omni_assistance/src/core/models/assistance_model.dart';
import 'package:omni_assistance_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:url_launcher/url_launcher.dart';

class AssistancePage extends StatefulWidget {
  const AssistancePage({Key? key}) : super(key: key);

  @override
  State<AssistancePage> createState() => _AssistancePageState();
}

class _AssistancePageState extends State<AssistancePage> {
  final AssistancesStore store = Modular.get();
  final AssistanceStore assistanceStore = Modular.get();
  final ScrollController scrollController = ScrollController();
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    store.params.limit = '10';
    store.getAssistancesList(store.params);
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.state.results!.length != store.state.count) {
        store.params.limit = (int.parse(store.params.limit!) + 10).toString();
        store.getAssistancesList(store.params);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    assistanceStore.update(AssistanceModel());
    return Scaffold(
      appBar: const NavBarWidget(title: AssistanceLabels.assistancePageTitle)
          .build(context) as AppBar,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFieldWidget(
              label: AssistanceLabels.assistancePageTicketsLabel,
              controller: textController,
              placeholder: AssistanceLabels.assistancePageTicketsPlaceholder,
              onChange: (String? input) {
                store.getAssistancesBySubject(input, store.params);
              },
              suffixIcon: SvgPicture.asset(
                Assets.search,
                package: AssetsPackage.omniGeneral,
                width: 25,
                height: 25,
              ),
            ),
          ),
          const AssistanceGeneralFiltersWidget(),
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
                  store.getAssistancesList(store.params);
                },
                child: _buildAssistanceListWidget,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomButtonWidget(
        onPressed: () => Modular.to.pushNamed('create_assistance'),
        text: AssistanceLabels.assistancePageOpenTicket,
        buttonType: BottomButtonType.outline,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await launchUrl(
            Uri.parse('https://wa.me/556231425363'),
            mode: LaunchMode.externalApplication,
          );
        },
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(children: [
          SvgPicture.asset(
            Assets.whatsapp,
            package: AssetsPackage.omniCore,
            width: 38,
            height: 38,
          ),
        ]),
      ),
    );
  }

  Widget get _buildAssistanceListWidget {
    return TripleBuilder<AssistancesStore, DioError, AssistanceResultsModel>(
      store: store,
      builder: (_, triple) {
        Widget loading = const SizedBox();
        if (triple.isLoading) {
          loading = const LoadingWidget();
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
                      onPressed: () => store.getAssistancesList(store.params),
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
            if (triple.state.results!.isEmpty && !triple.isLoading)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: EmptyWidget(
                    message: AssistanceLabels.assistancePageEmptyList,
                    textButton: AssistanceLabels.tryAgain,
                    onPressed: () => store.getAssistancesList(store.params),
                  ),
                ),
              ),
            if (triple.state.results!.isNotEmpty)
              AbsorbPointer(
                absorbing: triple.isLoading,
                child: Opacity(
                  opacity: triple.isLoading ? 0.75 : 1.0,
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: triple.state.results!.length,
                    itemBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7.5,
                      ),
                      child: GestureDetector(
                        onTap: () => Modular.to.pushNamed(
                          'assistance_details',
                          arguments: triple.state.results![index],
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.25),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      triple.state.results![index].subject!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      padding: const EdgeInsets.all(7.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: triple.state.results![index]
                                              .status!.color,
                                          width: 2,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                      ),
                                      child: Text(
                                        triple.state.results![index].status!
                                            .label,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              color: triple
                                                  .state
                                                  .results![index]
                                                  .status!
                                                  .color,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                SvgPicture.asset(
                                  Assets.arrowRight,
                                  package: AssetsPackage.omniGeneral,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            loading,
          ],
        );
      },
    );
  }
}
