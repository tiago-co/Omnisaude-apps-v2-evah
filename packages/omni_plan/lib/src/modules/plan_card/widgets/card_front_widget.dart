import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart'
    show Formaters, InputFieldShimmerWidget;
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/plan_card_model.dart';
import 'package:omni_plan/src/modules/plan_card/stores/plan_card_store.dart';
import 'package:plan_card_labels/labels.dart';

class CardFrontWidget extends StatefulWidget {
  const CardFrontWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CardFrontWidgetState createState() => _CardFrontWidgetState();
}

class _CardFrontWidgetState extends State<CardFrontWidget>
    with SingleTickerProviderStateMixin {
  final Duration duration = const Duration(milliseconds: 250);
  final PlanCardStore store = Modular.get();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
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
          store.getPlanCard();
        },
        child: Column(
          children: [
            Expanded(
              child: _buildCardWidget,
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildCardWidget {
    return TripleBuilder<PlanCardStore, DioError, PlanCardModel>(
      store: store,
      builder: (_, triple) {
        return _buildCardFrontWidget(triple);
      },
    );
  }

  Widget _buildCardFrontWidget(Triple triple) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).primaryColor,
        // color: Colors.black,
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset(
            Assets.logoPresentation,
            height: 40,
          ),
          const SizedBox(height: 10),
          _buildCardPlanNameWidget(triple.isLoading),
          const SizedBox(height: 5),
          _buildCartInfoWidget(
            label: PlanCardLabels.cardFrontName,
            value: store.userStore.beneficiary.individualPerson!.name,
            isLoading: triple.isLoading,
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                flex: 2,
                child: _buildCartInfoWidget(
                  label: PlanCardLabels.cardFrontEnrollment,
                  value: store.state.matricula,
                  isLoading: triple.isLoading,
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                child: _buildCartInfoWidget(
                  label: PlanCardLabels.cardFrontvalidity,
                  value: store.state.vencimento != null
                      ? Formaters.cardValid(
                          Formaters.stringToDate(store.state.vencimento!),
                        )
                      : null,
                  isLoading: triple.isLoading,
                  width: MediaQuery.of(context).size.width * 0.25,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardPlanNameWidget(bool isLoading) {
    if (isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputFieldShimmerWidget(
            height: Theme.of(context).textTheme.displaySmall!.fontSize!,
          ),
        ],
      );
    }
    return Text(
      store.state.plan?.name ?? PlanCardLabels.cardFrontPlanNameEmpty,
      maxLines: 1,
      style: Theme.of(context).textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
    );
  }

  Widget _buildCartInfoWidget({
    required String label,
    required String? value,
    bool isLoading = false,
    double width = double.infinity,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.white,
                height: 1,
              ),
        ),
        const SizedBox(height: 5),
        if (isLoading)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputFieldShimmerWidget(
                width: width,
                height: Theme.of(context).textTheme.displaySmall!.fontSize!,
              ),
            ],
          ),
        if (!isLoading)
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Text(
              value ?? '-',
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    height: 1,
                    color: Colors.white,
                  ),
            ),
          ),
      ],
    );
  }
}
