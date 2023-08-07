import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/refund_request_model.dart';
import 'package:omni_plan/src/modules/guide_providers/widgets/provider_item_shimmer_widget.dart';
import 'package:omni_plan/src/modules/refund_tab_status/stores/refund_request_store.dart';
import 'package:omni_plan/src/modules/refund_tab_status/widgets/filters/refund_request_general_filter_widget.dart';
import 'package:omni_plan/src/modules/refund_tab_status/widgets/refund_request_item_widget.dart';
import 'package:refund_tab_status_labels/labels.dart';

class RefundRequestPage extends StatefulWidget {
  const RefundRequestPage({Key? key}) : super(key: key);

  @override
  State<RefundRequestPage> createState() => _RefundRequestPageState();
}

class _RefundRequestPageState extends State<RefundRequestPage> {
  final ScrollController scrollController = ScrollController();
  final RefundRequestStore store = Modular.get();

  @override
  void initState() {
    super.initState();
    store.getAllRefundRequest();
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.state.results!.length != store.state.count) {
        store.params.limit = (int.parse(store.params.limit!) + 10).toString();
        store.getAllRefundRequest();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const NavBarWidget(title: RefundTabStatusLabels.refundRequestTitle)
              .build(context) as AppBar,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFieldWidget(
              keyboardType: TextInputType.number,
              label: RefundTabStatusLabels.refundRequestNumberLabel,
              placeholder: RefundTabStatusLabels.refundRequestNumberPlaceholder,
              controller: TextEditingController(),
              onChange: store.getRefundRequestParams,
            ),
          ),
          const RefundRequestGeneralFilterWidget(),
          const Divider(),
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
                  store.getAllRefundRequest().then((value) {
                    scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  });
                },
                child: TripleBuilder<RefundRequestStore, DioError,
                    RefundRequestResultsModel>(
                  store: store,
                  builder: (_, triple) {
                    Widget loading = const SizedBox();
                    if (triple.isLoading && store.state.results!.isEmpty) {
                      loading = const ProviderItemShimmerWidget();
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
                                  onPressed: () => store.getAllRefundRequest(),
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
                        if (store.state.results!.isEmpty && !triple.isLoading)
                          Column(
                            children: [
                              Expanded(
                                child: Center(
                                  child: SingleChildScrollView(
                                    clipBehavior: Clip.antiAlias,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    physics: const BouncingScrollPhysics(),
                                    child: EmptyWidget(
                                      message: RefundTabStatusLabels.refundRequestEmpty,
                                      textButton: RefundTabStatusLabels.tryAgain,
                                      onPressed: () =>
                                          store.getAllRefundRequest(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (store.state.results!.isNotEmpty)
                          ListView.separated(
                            separatorBuilder: (_, index) =>
                                const SizedBox(height: 10),
                            itemCount: store.state.results!.length,
                            controller: scrollController,
                            itemBuilder: (_, index) {
                              return Column(
                                children: [
                                  RefundRequestItemWidget(
                                    refundRequest: store.state.results![index],
                                  ),
                                  if (triple.isLoading &&
                                      index == triple.state.results!.length - 1)
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: LinearProgressIndicator(),
                                    ),
                                ],
                              );
                            },
                          ),
                        loading,
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
