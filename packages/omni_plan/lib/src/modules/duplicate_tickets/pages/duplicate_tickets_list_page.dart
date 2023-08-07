import 'package:dio/dio.dart';
import 'package:direct_debit_labels/labels.dart';
import 'package:duplicate_tickets_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/duplicate_ticket_model.dart';
import 'package:omni_plan/src/modules/duplicate_tickets/stores/duplicate_tickets_list_store.dart';
import 'package:omni_plan/src/modules/duplicate_tickets/widgets/duplicate_ticket_item_widget.dart';

class DuplicateTicketsListPage extends StatefulWidget {
  final String moduleName;

  const DuplicateTicketsListPage({
    Key? key,
    required this.moduleName,
  }) : super(key: key);

  @override
  State<DuplicateTicketsListPage> createState() =>
      _DuplicateTicketsListPageState();
}

class _DuplicateTicketsListPageState extends State<DuplicateTicketsListPage> {
  final DuplicateTicketsListStore store = Modular.get();

  @override
  void initState() {
    store.getDuplicateTicketsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName).build(context) as AppBar,
      body: TripleBuilder<DuplicateTicketsListStore, Exception,
          List<DuplicateTicketModel>>(
        store: store,
        builder: (context, triple) {
          if (triple.isLoading) {
            return const LoadingWidget();
          }
          if (triple.error != null) {
            return Center(
              child: RequestErrorWidget(
                error: triple.error as DioError,
                buttonText: DirectDebitLabels.directDebitBack,
                onPressed: () {
                  Modular.to.pop();
                },
              ),
            );
          }
          if (store.state.isEmpty && !triple.isLoading) {
            return Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      physics: const BouncingScrollPhysics(),
                      child: EmptyWidget(
                        message:
                            DuplicateTicketsLabels.duplicateTicketListEmpty,
                        textButton: DuplicateTicketsLabels.tryAgain,
                        onPressed: () => store.getDuplicateTicketsList(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              await store.getDuplicateTicketsList();
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: store.state.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return DuplicateTicketItemWidget(
                        model: store.state[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
