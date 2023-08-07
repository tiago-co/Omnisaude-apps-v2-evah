import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/refund_request_item_model.dart';
import 'package:omni_plan/src/core/models/refund_request_model.dart';
import 'package:omni_plan/src/modules/refund_tab_status/stores/refund_request_items_store.dart';
import 'package:omni_plan/src/modules/refund_tab_status/widgets/refund_request_item_header_widget.dart';
import 'package:omni_plan/src/modules/refund_tab_status/widgets/refund_request_items_item_widget.dart';
import 'package:refund_tab_status_labels/labels.dart';

class RefundRequestItemsPage extends StatefulWidget {
  final RefundRequestModel refundRequest;
  const RefundRequestItemsPage({
    Key? key,
    required this.refundRequest,
  }) : super(key: key);

  @override
  State<RefundRequestItemsPage> createState() => _RefundRequestItemsPageState();
}

class _RefundRequestItemsPageState extends State<RefundRequestItemsPage> {
  final RefundRequestItemsStore store = Modular.get();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    store.getRefundRequestItems(widget.refundRequest.requestSequenceNumber!);
    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.state.results!.length != store.state.count) {
        store.params.limit = (int.parse(store.params.limit!) + 10).toString();
        store
            .getRefundRequestItems(widget.refundRequest.requestSequenceNumber!);
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
      appBar: const NavBarWidget(
              title: RefundTabStatusLabels.refundRequestItemsTitle)
          .build(context) as AppBar,
      body: TripleBuilder<RefundRequestItemsStore, DioError,
          RefundRequestItemResultsModel>(
        store: store,
        builder: (context, triple) {
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
                      physics: const BouncingScrollPhysics(),
                      child: RequestErrorWidget(
                        error: triple.error,
                        onPressed: () => store.getRefundRequestItems(
                          widget.refundRequest.requestSequenceNumber!,
                        ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          physics: const BouncingScrollPhysics(),
                          child: EmptyWidget(
                            message:
                                RefundTabStatusLabels.refundRequestItemsEmpty,
                            textButton: RefundTabStatusLabels.tryAgain,
                            onPressed: () => store.getRefundRequestItems(
                              widget.refundRequest.requestSequenceNumber!,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (store.state.results!.isNotEmpty && !triple.isLoading)
                Scrollbar(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        RefundRequestItemHeaderWidget(
                          refundRequest: widget.refundRequest,
                        ),
                        const Divider(),
                        Expanded(
                          child: AbsorbPointer(
                            absorbing: triple.isLoading,
                            child: Opacity(
                              opacity: triple.isLoading ? 0.77 : 1,
                              child: ListView.separated(
                                separatorBuilder: (_, index) =>
                                    const SizedBox(height: 10),
                                itemCount: store.state.results!.length,
                                itemBuilder: (_, index) {
                                  return RefundRequestItemsItemWidget(
                                    refundRequestItem:
                                        store.state.results![index],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              loading,
            ],
          );
        },
      ),
    );
  }
}
