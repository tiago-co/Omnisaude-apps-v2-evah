import 'package:duplicate_tickets_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/duplicate_ticket_model.dart';

import 'package:omni_plan/src/modules/duplicate_tickets/stores/duplicate_ticket_pdf_store.dart';

import 'package:omni_plan/src/modules/duplicate_tickets/stores/duplicate_tickets_list_store.dart';

class DuplicateTicketItemWidget extends StatelessWidget {
  final DuplicateTicketModel model;
  const DuplicateTicketItemWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  Color getCardColor() {
    if (model.expiryTime != null &&
        model.expiryTime!.toUpperCase().contains('VENCIDO')) {
      return Colors.red;
    }
    return Colors.amber;
  }

  @override
  Widget build(BuildContext context) {
    final PdfViewService service = PdfViewService();
    final DuplicateTicketPdfStore store = Modular.get();
    final DuplicateTicketsListStore duplicateTicketsListStore = Modular.get();
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: Theme.of(context).cardColor.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DuplicateTicketsLabels.duplicateTicketItemDueDate,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'R\$ ${Formaters.formatNumber(
                      model.monthlyValue!.toDouble(),
                    )}',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).cardColor,
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: getCardColor().withOpacity(0.1),
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: getCardColor()),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: getCardColor(),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      model.expiryTime ?? '-',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: getCardColor(),
                            fontWeight: FontWeight.bold,
                          ),
                    )
                  ],
                ),
              )
            ],
          ),
          Divider(
            color: Theme.of(context).cardColor,
            thickness: 0.75,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vencimento',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  Formaters.dateToStringDate(
                    Formaters.stringToDate(model.dueDate!),
                  ),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).cardColor,
                        fontSize: 15,
                      ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: model.ieBoleto == 'S',
            child: Divider(
              color: Theme.of(context).cardColor,
              thickness: 0.75,
            ),
          ),
          Visibility(
            visible: model.ieBoleto == 'S',
            child: const SizedBox(
              height: 10,
            ),
          ),
          Visibility(
            visible: model.ieBoleto == 'S',
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DefaultButtonWidget(
                    onPressed: () {
                      Helpers.copyText(context, model.ticketCode);
                    },
                    text: DuplicateTicketsLabels.duplicateTicketItemCopyCode,
                    buttonType: DefaultButtonType.outline,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: DefaultButtonWidget(
                    onPressed: () async {
                      await store
                          .getDuplicateTicketPDF(
                        model.monthlyPaymentId.toString(),
                        service,
                      )
                          .then(
                        (value) {
                          Modular.to.pushNamed(
                            '/home/omniPlan/duplicateTickets/duplicateTicketPdfPage',
                            arguments: {
                              'monthlyPaymentId': model.monthlyPaymentId,
                              'service': service,
                            },
                          ).then(
                            (value) {
                              duplicateTicketsListStore.setLoading(false);
                            },
                          );
                        },
                      );
                    },
                    text: DuplicateTicketsLabels.duplicateTicketItemSeeTicket,
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            visible: model.ieBoleto == 'N',
            child: Text(
              '⚠️ Boleto cadastrado no débito automático',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: Theme.of(context).cardColor,
                    fontSize: 14,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
