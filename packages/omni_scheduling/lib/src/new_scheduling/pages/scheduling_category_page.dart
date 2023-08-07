import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/omni_scheduling.dart';
import 'package:omni_scheduling/src/core/enums/scheduling_step_enum.dart';
import 'package:omni_scheduling/src/core/models/professional_model.dart';
import 'package:omni_scheduling/src/core/models/specialty_model.dart';
import 'package:omni_scheduling/src/new_scheduling/pages/widgets/scheduling_progress_widget.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_category_store.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_specialty_store.dart';
import 'package:omni_scheduling/src/new_scheduling/stores/new_scheduling_store.dart';
import 'package:omni_scheduling_labels/labels.dart';

class SchedulingCategoryPage extends StatefulWidget {
  final PageController pageController;
  final SchedulingType schedulingType;
  final SchedulingModeType schedulingModeType;

  const SchedulingCategoryPage({
    Key? key,
    required this.pageController,
    required this.schedulingModeType,
    required this.schedulingType,
  }) : super(key: key);

  @override
  _SchedulingCategoryPageState createState() => _SchedulingCategoryPageState();
}

class _SchedulingCategoryPageState extends State<SchedulingCategoryPage> {
  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final NewSchedulingSpecialtyStore specialtyStore = Modular.get();
  final NewSchedulingCategoryStore categoryStore = Modular.get();
  final NewSchedulingStore store = Modular.get();

  @override
  void initState() {
    categoryStore.getSchedulingCategory();
    super.initState();
  }

  @override
  void dispose() {
    specialtyController.dispose();
    categoryController.dispose();
    categoryStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 15),
        if (widget.schedulingModeType != SchedulingModeType.mediktor)
          SchedulingProgressWidget(
            modeType: widget.schedulingModeType,
            step: 1,
            progress: 0.33,
            type: SchedulingStepType.schedulingCategory,
            nextTitle: SchedulingLabels.schedulingCategoryNextTitle,
          ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCategorySelectWidget,
                const SizedBox(height: 15),
                _buildSpecialtySelectWidget,
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget get _buildCategorySelectWidget {
    return TripleBuilder<NewSchedulingCategoryStore, DioError,
        List<ProfessionalCategoryModel>>(
      store: categoryStore,
      builder: (_, triple) {
        return GestureDetector(
          onTap: () {
            categoryStore.getSchedulingCategory();
          },
          child: SelectFieldWidget<ProfessionalCategoryModel>(
            label: SchedulingLabels.schedulingCategoryLabel,
            placeholder: SchedulingLabels.schedulingCategoryPlaceholder,
            controller: categoryController,
            showSearch: true,
            items: triple.state,
            itemsLabels:
                triple.state.map((category) => category.labelType!).toList(),
            isLoading: triple.isLoading,
            isEnabled: triple.event != TripleEvent.error &&
                (triple.state.isNotEmpty && !triple.isLoading),
            errorText: triple.event == TripleEvent.error
                ? SchedulingLabels.schedulingCategoryGeneralError
                : triple.state.isEmpty && !triple.isLoading
                    ? SchedulingLabels.schedulingCategoryEmpty
                    : null,
            onSelectItem: (category) {
              store.params.professionaType = category.type;
              store.params.type = widget.schedulingType.toJson;
              categoryController.text = category.labelType!;
              store.state.category = category.type;
              store.updateForm(store.state);
              store.state.specialty = null;
              specialtyController.clear();
              specialtyStore.getSpecialties(store.params);
            },
          ),
        );
      },
    );
  }

  Widget get _buildSpecialtySelectWidget {
    return TripleBuilder<NewSchedulingSpecialtyStore, DioError,
        List<SpecialtyModel>>(
      store: specialtyStore,
      builder: (_, triple) {
        return GestureDetector(
          onTap: store.state.category != null
              ? () {
                  specialtyStore.getSpecialties(store.params);
                }
              : null,
          child: SelectFieldWidget<SpecialtyModel>(
            label: SchedulingLabels.schedulingCategorySpecialtyLabel,
            placeholder:
                SchedulingLabels.schedulingCategorySpecialtyPlaceholder,
            controller: specialtyController,
            showSearch: true,
            items: triple.state,
            itemsLabels:
                triple.state.map((specialty) => specialty.name!).toList(),
            isEnabled: store.state.category != null &&
                triple.event != TripleEvent.error &&
                (triple.state.isNotEmpty && !triple.isLoading),
            errorText: triple.event == TripleEvent.error
                ? SchedulingLabels.schedulingCategoryGeneralError
                : triple.state.isEmpty &&
                        !triple.isLoading &&
                        store.state.category != null
                    ? SchedulingLabels.schedulingCategorySpecialtyEmpty
                    : null,
            isLoading: triple.isLoading,
            onSelectItem: (specialty) {
              specialtyController.text = specialty.name!;
              store.params.specialty = specialty.name;
              store.state.specialty = specialty.id;
              store.updateForm(store.state);
            },
          ),
        );
      },
    );
  }
}
