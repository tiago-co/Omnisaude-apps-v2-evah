import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/nurse_evolution_form/nurse_evolution_form_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/stores/nurse_evolution_form_store.dart';
import 'package:omni_trilhas/src/modules/evolution_form/widgets/details_item_shimmer.dart';
import 'package:omni_trilhas/src/modules/evolution_form/widgets/subsection_widget.dart';

class NurseEvoltuionDetailWidget extends StatefulWidget {
  final String evolutionFormId;
  const NurseEvoltuionDetailWidget({
    Key? key,
    required this.evolutionFormId,
  }) : super(key: key);

  @override
  State<NurseEvoltuionDetailWidget> createState() =>
      _NurseEvoltuionDetailWidgetState();
}

class _NurseEvoltuionDetailWidgetState
    extends State<NurseEvoltuionDetailWidget> {
  final NurseEvolutionFormStore store = Modular.get();

  @override
  void initState() {
    store.getNurseEvolutionById(widget.evolutionFormId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<NurseEvolutionFormStore, DioError,
        NurseEvolutionFormModel>(
      store: store,
      builder: (_, triple) {
        if (triple.isLoading) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                itemCount: 20,
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
                      onPressed: () => store.getNurseEvolutionById(
                        widget.evolutionFormId,
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
                      visible: store.state.abdominalEvaluation != null,
                      child: SubsectionWidget(
                        subtitle: 'Avaliação Abdominal',
                        data: store.state.abdominalEvaluation!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.cardiologicalEvaluation != null,
                      child: SubsectionWidget(
                        subtitle: 'Avaliação Cardiaca',
                        data: store.state.cardiologicalEvaluation!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.evaluationVentilation != null,
                      child: SubsectionWidget(
                        subtitle: 'Avaliação de Ventilação',
                        data: store.state.evaluationVentilation!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.genitalAssessment != null,
                      child: SubsectionWidget(
                        subtitle: 'Avaliação Genital',
                        data: store.state.genitalAssessment!.getData(),
                      ),
                    ),
                    if (store.state.globalAssessment != null)
                      Visibility(
                        child: SubsectionWidget(
                          subtitle: 'Avaliação Global',
                          data: store.state.globalAssessment!.getData(),
                        ),
                      ),
                    Visibility(
                      visible: store.state.invasiveDevices != null,
                      child: SubsectionWidget(
                        subtitle: 'Dispositivo Invasivos',
                        data: store.state.invasiveDevices!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.neurologicalAssessment != null,
                      child: SubsectionWidget(
                        subtitle: 'Avaliação Neurologica',
                        data: store.state.neurologicalAssessment!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.nutritionalTherapy != null,
                      child: SubsectionWidget(
                        subtitle: 'Terapia Nutricional',
                        data: store.state.nutritionalTherapy!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.pendencies != null,
                      child: SubsectionWidget(
                        subtitle: 'Pendências',
                        data: store.state.pendencies!.getData(),
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
