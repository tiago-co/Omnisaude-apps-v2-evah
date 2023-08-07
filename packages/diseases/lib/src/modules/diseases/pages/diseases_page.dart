import 'package:diseases/src/modules/diseases/pages/allergy_list_page.dart';
import 'package:diseases/src/modules/diseases/pages/diseases_list_page.dart';
import 'package:diseases/src/modules/diseases/stores/disease_category_type_store.dart';
import 'package:diseases/src/modules/diseases/widgets/disease_type_filter_widget.dart';
import 'package:diseases_labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';

class DiseasesPage extends StatelessWidget {
  final String moduleName;
  const DiseasesPage({Key? key, required this.moduleName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final DiseaseCategoryTypeStore diseaseCategoryTypeStore = Modular.get();

    return Scaffold(
      appBar: const NavBarWidget(title: DiseasesLabels.diseasesTitle)
          .build(context) as AppBar,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DiseaseTypeFilterWidget(
              pageController: pageController,
            ),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  DiseasesListPage(),
                  AllergyListPage(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButtonWidget(
        onPressed: () {
          diseaseCategoryTypeStore.updateForm('');
          Modular.to.pushNamed(
            '../diseases/createDisease',
          );
        },
        buttonType: BottomButtonType.outline,
        text: DiseasesLabels.createNewDiseaseAdd,
      ),
    );
  }
}
