import 'package:flutter/material.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_trilhas/src/modules/evolution_form/core/enuns/evolution_form_enum.dart';
import 'package:omni_trilhas/src/modules/evolution_form/stores/evolution_forms_list_store.dart';
import 'package:omni_trilhas/src/modules/evolution_form/widgets/evolution_form_tab_view.dart';

class EvolutionFormPage extends StatefulWidget {
  const EvolutionFormPage({Key? key}) : super(key: key);

  @override
  State<EvolutionFormPage> createState() => _EvolutionFormPageState();
}

class _EvolutionFormPageState extends State<EvolutionFormPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final EvolutionFormsListStore medicalStore =
      EvolutionFormsListStore(EvolutionFormType.doctor);
  final EvolutionFormsListStore nurseStore =
      EvolutionFormsListStore(EvolutionFormType.nursing);
  final EvolutionFormsListStore nursingTechnicianStore =
      EvolutionFormsListStore(EvolutionFormType.technicalNursing);
  final EvolutionFormsListStore nutritionistStore =
      EvolutionFormsListStore(EvolutionFormType.nutritionist);
  final EvolutionFormsListStore physiotherapyStore =
      EvolutionFormsListStore(EvolutionFormType.physiotherapist);
  final EvolutionFormsListStore psychologistStore =
      EvolutionFormsListStore(EvolutionFormType.psychologist);
  final EvolutionFormsListStore therapistStore =
      EvolutionFormsListStore(EvolutionFormType.therapist);

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: EvolutionFormType.values.length, vsync: this);
    medicalStore.getSpecificEvolutionForm();
    nurseStore.getSpecificEvolutionForm();
    nursingTechnicianStore.getSpecificEvolutionForm();
    nutritionistStore.getSpecificEvolutionForm();
    physiotherapyStore.getSpecificEvolutionForm();
    psychologistStore.getSpecificEvolutionForm();
    therapistStore.getSpecificEvolutionForm();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: EvolutionFormType.values.length,
      child: Scaffold(
        appBar: NavBarWidget(
          title: 'Minhas Evoluções',
          bottom: TabBar(
            labelStyle: Theme.of(context).textTheme.headlineMedium,
            unselectedLabelStyle: Theme.of(context).textTheme.headlineSmall,
            indicatorColor: Theme.of(context).primaryColor,
            isScrollable: true,
            controller: _tabController,
            tabs: EvolutionFormType.values
                .map((evolutionFormType) => Tab(
                      text: evolutionFormType.label,
                    ))
                .toList(),
          ),
        ).build(context) as AppBar,
        body: TabBarView(
          controller: _tabController,
          children: [
            EvolutionFormTabView(store: medicalStore),
            EvolutionFormTabView(store: nurseStore),
            EvolutionFormTabView(store: physiotherapyStore),
            EvolutionFormTabView(store: nutritionistStore),
            EvolutionFormTabView(store: psychologistStore),
            EvolutionFormTabView(store: nursingTechnicianStore),
            EvolutionFormTabView(store: therapistStore),
          ],
        ),
      ),
    );
  }
}
