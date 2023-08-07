import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart'
    show LoadingWidget, QrCodeWidget;
import 'package:omni_plan/src/core/models/plan_card_model.dart';
import 'package:omni_plan/src/modules/plan_card/stores/plan_card_store.dart';
import 'package:plan_card_labels/labels.dart';

class CardBackWidget extends StatefulWidget {
  const CardBackWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CardBackWidgetState createState() => _CardBackWidgetState();
}

class _CardBackWidgetState extends State<CardBackWidget>
    with SingleTickerProviderStateMixin {
  final PlanCardStore store = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: TripleBuilder<PlanCardStore, DioError, PlanCardModel>(
        store: store,
        builder: (_, triple) {
          if (triple.isLoading) {
            return const LoadingWidget();
          }
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor,
            ),
            child: SingleChildScrollView(
              child: store.state.matricula!.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              QrCodeWidget(code: store.state.matricula!)
                            ],
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        PlanCardLabels.cardBackEmpty,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.background,
                            ),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }
}
