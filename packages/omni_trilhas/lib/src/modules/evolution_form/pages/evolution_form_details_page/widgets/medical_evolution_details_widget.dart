import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/models/doctor_evolution_form/evolution_form_doctor_model.dart';
import 'package:omni_trilhas/src/modules/evolution_form/stores/medical_evolution_form_store.dart';
import 'package:omni_trilhas/src/modules/evolution_form/widgets/details_item_shimmer.dart';
import 'package:omni_trilhas/src/modules/evolution_form/widgets/subsection_widget.dart';

class MedicalEvoltuionDetailPage extends StatefulWidget {
  final String evolutionFormId;
  const MedicalEvoltuionDetailPage({
    Key? key,
    required this.evolutionFormId,
  }) : super(key: key);

  @override
  State<MedicalEvoltuionDetailPage> createState() =>
      _MedicalEvoltuionDetailPageState();
}

class _MedicalEvoltuionDetailPageState
    extends State<MedicalEvoltuionDetailPage> {
  final MedicalEvolutionFormStore store = Modular.get();

  @override
  void initState() {
    store.getMedicalEvolutionById(widget.evolutionFormId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<MedicalEvolutionFormStore, DioError,
        EvolutionFormDoctorModel>(
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
                      onPressed: () => store.getMedicalEvolutionById(
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
                      visible: store.state.cardiologicalEvaluation != null,
                      child: SubsectionWidget(
                        subtitle: 'Avaliação Cardiologica',
                        data: store.state.cardiologicalEvaluation!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.respiratoryEvaluation != null,
                      child: SubsectionWidget(
                        subtitle: 'Avaliação Respiratória',
                        data: store.state.respiratoryEvaluation!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.neurologicalEvalutation != null,
                      child: SubsectionWidget(
                        subtitle: 'Avaliação Neurológica',
                        data: store.state.neurologicalEvalutation!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.abdominalEvaluation != null,
                      child: SubsectionWidget(
                        subtitle: 'Avaliação Abdominal',
                        data: store.state.abdominalEvaluation!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.diagnosticDoctor != null,
                      child: SubsectionWidget(
                        subtitle: 'Diagnóstico',
                        data: store.state.diagnosticDoctor!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.physicalExam != null,
                      child: SubsectionWidget(
                        subtitle: 'Exame Físico',
                        data: store.state.physicalExam!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.medicalImpression != null,
                      child: SubsectionWidget(
                        subtitle: 'Impressão Médica',
                        data: store.state.medicalImpression!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.therapeuticPlan != null,
                      child: SubsectionWidget(
                        subtitle: 'Plano Terapêutico',
                        data: store.state.therapeuticPlan!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.filedBy != null,
                      child: SubsectionWidget(
                        subtitle: 'Preechido Por',
                        data: store.state.filedBy!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.medicalConduct != null,
                      child: SubsectionWidget(
                        subtitle: 'Conduta Médica',
                        data: store.state.medicalConduct!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.vitalSigns != null,
                      child: SubsectionWidget(
                        subtitle: 'Sinais Vitais',
                        data: store.state.vitalSigns!.getData(),
                      ),
                    ),
                    Visibility(
                      visible: store.state.indicators24Hours != null,
                      child: SubsectionWidget(
                        subtitle: 'Indicadores 24 Horas',
                        data: store.state.indicators24Hours!.getData(),
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
