import 'package:benefits_labels/labels.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/modules/benefits/discounts/stores/cupons_list_store.dart';
import 'package:omni_general/omni_general.dart';

class DiscountDetail extends StatefulWidget {
  const DiscountDetail({required this.organizationId, Key? key}) : super(key: key);
  final int organizationId;

  @override
  State<DiscountDetail> createState() => _DiscountDetailState();
}

class _DiscountDetailState extends State<DiscountDetail> {
  final CuponsListStore store = CuponsListStore();

  @override
  void initState() {
    super.initState();
    // store.params.usageType = widget.couponRescueType;
    store.params.usageType = 'online';
    store.getOrganizationCupons(organzationId: widget.organizationId);
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selecione um desconto',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TripleBuilder<CuponsListStore, DioError, List<CupomModel>>(
              store: store,
              builder: (_, triple) {
                if (triple.isLoading) {
                  return const Center(child: LoadingWidget());
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
                  return SizedBox(
                    height: 450,
                    child: Center(
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
                      final cupomModel = store.state[index];
                      return Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(vertical: 26),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Helpers.getTextColor(cupomModel.discount!),
                          ),
                          borderRadius: BorderRadius.circular(12 * fem),
                          color: Helpers.getBackgroundColor(cupomModel.discount!),
                        ),
                        child: Column(
                          children: [
                            // Positioned(
                            //   // rectangle8Jfy (2635:18069)
                            //   left: 10 * fem,
                            //   top: 10 * fem,
                            //   child: Align(
                            Text(
                              'Até ${cupomModel.discount}% off',
                              style: TextStyle(
                                fontSize: 22 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.2999999306 * ffem / fem,
                                color: Helpers.getTextColor(cupomModel.discount!),
                              ),
                            ),

                            Text(
                              'Valido até ${Formaters.dateToStringDate(
                                Formaters.stringToDate(cupomModel.endDate!),
                              )}',
                              style: TextStyle(
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.4000000272 * ffem / fem,
                                color: const Color(0xff52576a),
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: SingleChildScrollView(
                                        child: Container(
                                          color: Theme.of(context).scaffoldBackgroundColor,
                                          padding: const EdgeInsets.only(
                                            left: 16,
                                            right: 16,
                                            bottom: 16,
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: IconButton(
                                                  onPressed: () => Modular.to.pop(),
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                cupomModel.description!,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 14),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: Container(
                                width: 119 * fem,
                                height: 32 * fem,
                                child: Container(
                                  // masterbuttonmasterjPu (I2635:18083;1106:10392)
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Helpers.getTextColor(cupomModel.discount!),
                                    borderRadius: BorderRadius.circular(60 * fem),
                                  ),
                                  child: Center(
                                    child: Center(
                                      child: Text(
                                        'Resgatar',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.7142857143 * ffem / fem,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
