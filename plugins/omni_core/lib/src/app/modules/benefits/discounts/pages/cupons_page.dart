import 'package:benefits_labels/labels.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/cupons_list_store.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/widgets/cupon_card_widget.dart';
import 'package:omni_general/omni_general.dart';

class CuponsPage extends StatefulWidget {
  final int organizationId;
  final String? couponRescueType;
  final String moduleName;
  final String coverImage;
  const CuponsPage({
    Key? key,
    required this.organizationId,
    required this.moduleName,
    required this.coverImage,
    this.couponRescueType,
  }) : super(key: key);

  @override
  State<CuponsPage> createState() => _CuponsPageState();
}

class _CuponsPageState extends State<CuponsPage> {
  final CuponsListStore store = CuponsListStore();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // store.params.usageType = widget.couponRescueType;
    store.params.usageType = 'physical';
    store.getOrganizationCupons(organzationId: widget.organizationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBarWidget(title: widget.moduleName).build(context) as AppBar,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: TripleBuilder<CuponsListStore, DioError, List<CupomModel>>(
          store: store,
          builder: (_, triple) {
            if (triple.isLoading) {
              return const LoadingWidget();
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
                          onPressed: () => store.getOrganizationCupons(
                            organzationId: widget.organizationId,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }
            if (!triple.isLoading && triple.state.isEmpty) {
              return Center(
                child: SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  physics: const BouncingScrollPhysics(),
                  child: EmptyWidget(
                    message: BenefitsLabels.cuponsEmpty,
                    textButton: BenefitsLabels.tryAgain,
                    onPressed: () => store.getOrganizationCupons(
                      organzationId: widget.organizationId,
                    ),
                  ),
                ),
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                await store.getOrganizationCupons(
                  organzationId: widget.organizationId,
                );
              },
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const SizedBox(height: 20),
                shrinkWrap: true,
                itemCount: store.state.length > 3 ? 3 : store.state.length,
                itemBuilder: (_, index) {
                  store.state[index].organizationId = widget.organizationId;

                  return CuponCardWidget(
                    model: store.state[index],
                    coverImage: widget.coverImage,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
