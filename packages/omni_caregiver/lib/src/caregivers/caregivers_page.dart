import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_caregiver/src/caregivers/caregivers_store.dart';
import 'package:omni_caregiver/src/caregivers/widgets/caregiver_item_shimmer_widget.dart';
import 'package:omni_caregiver/src/caregivers/widgets/caregiver_item_widget.dart';
import 'package:omni_caregiver/src/core/models/caregiver_model.dart';
import 'package:omni_caregiver_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

class CaregiversPage extends StatefulWidget {
  final String moduleName;
  const CaregiversPage({Key? key, required this.moduleName}) : super(key: key);
  @override
  CaregiversPageState createState() => CaregiversPageState();
}

class CaregiversPageState extends State<CaregiversPage> {
  final CaregiversStore store = Modular.get();
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    store.params.limit = '10';

    store.getCaregivers(store.params);

    scrollController.addListener(() {
      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          store.state.results!.length != store.state.count) {
        store.params.limit = (int.parse(store.params.limit!) + 10).toString();
        store.getCaregivers(store.params);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName).build(context) as AppBar,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextFieldWidget(
                label: CaregiverLabels.caregiversCaregiversLabel,
                controller: textController,
                placeholder: CaregiverLabels.caregiversCaregiverPlaceholder,
                onChange: (String? input) {
                  store.getCaregiversByName(input, store.params);
                },
                suffixIcon: SvgPicture.asset(
                  Assets.search,
                  package: AssetsPackage.omniGeneral,
                  width: 25,
                  height: 25,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Theme(
                data: Theme.of(context).copyWith(
                  shadowColor: Colors.transparent,
                ),
                child: RefreshIndicator(
                  displacement: 0,
                  strokeWidth: 0.75,
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Theme.of(context).colorScheme.background,
                  triggerMode: RefreshIndicatorTriggerMode.anywhere,
                  onRefresh: () async {
                    store.getCaregivers(store.params);
                  },
                  child: _buildCaregiversListWidget,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomButtonWidget(
        onPressed: () {
          Modular.to.pushNamed('newCaregiver', arguments: widget.moduleName);
        },
        buttonType: BottomButtonType.outline,
        text: CaregiverLabels.caregiversNewCaregiver,
      ),
    );
  }

  Widget get _buildCaregiversListWidget {
    return TripleBuilder<CaregiversStore, DioError, CaregiverResultsModel>(
      store: store,
      builder: (_, triple) {
        Widget loading = const SizedBox();
        if (triple.isLoading) loading = const CaregiverItemShimmerWidget();
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
                      onPressed: () => store.getCaregivers(store.params),
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
            if (triple.state.results!.isEmpty)
              Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        clipBehavior: Clip.antiAlias,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        physics: const BouncingScrollPhysics(),
                        child: EmptyWidget(
                          message: CaregiverLabels.caregiversEmptyList,
                          textButton: CaregiverLabels.tryAgain,
                          onPressed: () => store.getCaregivers(store.params),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (triple.state.results!.isNotEmpty)
              ListView.builder(
                controller: scrollController,
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                itemCount: triple.state.results!.length,
                padding: const EdgeInsets.all(15),
                itemBuilder: (_, index) {
                  return CaregiverItemWidget(
                    caregiver: triple.state.results![index],
                  );
                },
              ),
            loading,
          ],
        );
      },
    );
  }
}
