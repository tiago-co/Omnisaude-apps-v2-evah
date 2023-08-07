import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_general/omni_general.dart'
    show
        BottomButtonType,
        BottomButtonWidget,
        Formaters,
        InputFieldShimmerWidget,
        StatusTypeExtension;
import 'package:omni_plan/src/core/models/plan_card_model.dart';
import 'package:omni_plan/src/modules/plan_card/stores/plan_card_store.dart';
import 'package:plan_card_labels/labels.dart';

class CardInfoWidget extends StatefulWidget {
  final PageController pageController;
  const CardInfoWidget({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  _CardInfoWidgetState createState() => _CardInfoWidgetState();
}

class _CardInfoWidgetState extends State<CardInfoWidget> {
  final Duration duration = const Duration(milliseconds: 250);
  final PlanCardStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                store.getPlanCard();
              },
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(15),
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      child: _buildFormWidget,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        BottomButtonWidget(
          onPressed: () {
            widget.pageController.previousPage(
              duration: duration,
              curve: Curves.decelerate,
            );
          },
          buttonType: BottomButtonType.outline,
          text: PlanCardLabels.cardInfoMyCard,
        ),
      ],
    );
  }

  Widget get _buildFormWidget {
    return TripleBuilder<PlanCardStore, DioError, PlanCardModel>(
      store: store,
      builder: (_, triple) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInfoHeaderWidget(
              plan: triple.state,
              isLoading: triple.isLoading,
            ),
            const SizedBox(height: 35),
            _buildInfoRowWidget(
              label: PlanCardLabels.cardInfoStatus,
              value: triple.state.status?.label,
              isLoading: triple.isLoading,
            ),
            const SizedBox(height: 15),
            _buildInfoRowWidget(
              label: PlanCardLabels.cardInfoCode,
              value: triple.state.code,
              isLoading: triple.isLoading,
            ),
            const SizedBox(height: 15),
            _buildInfoRowWidget(
              label: PlanCardLabels.cardInfoEnrollment,
              value: triple.state.matricula,
              isLoading: triple.isLoading,
            ),
            const SizedBox(height: 15),
            _buildInfoRowWidget(
              label: PlanCardLabels.cardInfoMaturity,
              value: store.state.vencimento != null
                  ? Formaters.cardValid(
                      Formaters.stringToDate(store.state.vencimento!),
                    )
                  : null,
              isLoading: triple.isLoading,
            ),
            const SizedBox(height: 15),
            _buildInfoRowWidget(
              label: PlanCardLabels.cardInfoCategory,
              value: triple.state.category,
              isLoading: triple.isLoading,
            ),
            const SizedBox(height: 15),
          ],
        );
      },
    );
  }

  Widget _buildInfoHeaderWidget({
    required PlanCardModel plan,
    bool isLoading = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Theme.of(context).cardColor.withOpacity(0.05),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            store.state.plan?.name ?? 'Sem nome',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildRegisterInfoWidget(
                  label: 'Registro',
                  value: plan.plan?.register,
                  isLoading: isLoading,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: _buildRegisterInfoWidget(
                  label: 'Registro ANS',
                  value: plan.plan?.ansRegister,
                  isLoading: isLoading,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildRegisterInfoWidget({
    required String label,
    required String? value,
    bool isLoading = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).cardColor.withOpacity(0.75),
              ),
        ),
        const SizedBox(height: 10),
        if (isLoading)
          InputFieldShimmerWidget(
            height: Theme.of(context).textTheme.headlineSmall!.fontSize!,
          ),
        if (!isLoading)
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Tooltip(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              message: value ?? '-',
              child: Text(
                value ?? '-',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).cardColor.withOpacity(0.75),
                      fontSize: 15,
                    ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRowWidget({
    required String label,
    required String? value,
    bool isLoading = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                scrollDirection: Axis.horizontal,
                child: Text(
                  label,
                  softWrap: false,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Theme.of(context).cardColor.withOpacity(0.75),
                        fontSize: 15,
                      ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            if (isLoading)
              Expanded(
                child: InputFieldShimmerWidget(
                  height: Theme.of(context).textTheme.headlineSmall!.fontSize!,
                ),
              ),
            if (!isLoading)
              Expanded(
                child: SelectableText(
                  value ?? '-',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              )
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}
