import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/evolution_form_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/generic_evolution_form/generic_evolution_form.dart';
import 'package:omni_trilhas/src/modules/evolution_form/stores/generic_evolution_form_store.dart';
import 'package:omni_trilhas/src/modules/evolution_form/widgets/details_item_shimmer.dart';
import 'package:omni_trilhas/src/modules/evolution_form/widgets/subsection_widget.dart';

class GenericEvolutionDetailsWidget extends StatefulWidget {
  final String id;
  final EvolutionFormType evolutionFormType;
  const GenericEvolutionDetailsWidget({
    Key? key,
    required this.id,
    required this.evolutionFormType,
  }) : super(key: key);

  @override
  State<GenericEvolutionDetailsWidget> createState() =>
      _GenericEvolutionDetailsWidgetState();
}

class _GenericEvolutionDetailsWidgetState
    extends State<GenericEvolutionDetailsWidget> {
  final GenericEvolutionFormStore store = Modular.get();

  @override
  void initState() {
    store.getGenericEvolutionById(widget.id, widget.evolutionFormType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<GenericEvolutionFormStore, DioError,
        GenericEvolutionFormModel>(
      store: store,
      builder: (_, triple) {
        if (triple.isLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) => Column(
                  children: const [
                    DetailsItemShimmer(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
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
                      onPressed: () => store.getGenericEvolutionById(
                        widget.id,
                        widget.evolutionFormType,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Visibility(
                      visible: store.state.overallImpression != null,
                      child: SubsectionWidget(
                        subtitle: 'Impressão Geral',
                        data: store.state.overallImpression!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.filedBy != null,
                      child: SubsectionWidget(
                        subtitle: 'Preenchido Por',
                        data: store.state.filedBy!.getData(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
