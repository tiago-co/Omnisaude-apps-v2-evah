import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:guide_providers_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_plan/src/core/models/plan_provider_model.dart';
import 'package:omni_plan/src/modules/guide_providers/stores/guide_providers_store.dart';
import 'package:omni_plan/src/modules/guide_providers/widgets/show_more/show_more_store.dart';
import 'package:omni_plan/src/modules/guide_providers/widgets/show_more/show_more_widget.dart';

class ProviderItemWidget extends StatefulWidget {
  final PlanProviderModel provider;
  const ProviderItemWidget({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  _ProviderItemWidgetState createState() => _ProviderItemWidgetState();
}

class _ProviderItemWidgetState extends State<ProviderItemWidget>
    with SingleTickerProviderStateMixin {
  final ShowMoreStore showMoreStore = Modular.get<ShowMoreStore>();
  final Duration duration = const Duration(milliseconds: 300);
  late AnimationController animationController;
  late Animation animation;

  final GuideProvidersStore store = Modular.get();

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: duration);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      animationController,
    );
    super.initState();
  }

  String buildSpecialtiesString() {
    if (widget.provider.dsEspecialidades!.isEmpty) {
      return GuideProvidersLabels.providerItemEmptySpecialties;
    }
    return widget.provider.dsEspecialidades!;
  }

  String buildProviderLocationString() {
    String providerLocation = '';
    providerLocation += widget.provider.dsLogradouro!.isEmpty
        ? ''
        : '${widget.provider.dsLogradouro},';

    providerLocation += widget.provider.nrEndereco!.isEmpty
        ? ''
        : '${widget.provider.nrEndereco}, ';

    providerLocation += widget.provider.dsBairro!.isEmpty
        ? ''
        : '${widget.provider.dsBairro}, ';

    providerLocation += widget.provider.dsComplemento!.isEmpty
        ? ''
        : '${widget.provider.dsComplemento}\n';
    providerLocation += widget.provider.dsMunicipio!.isEmpty
        ? ''
        : '${widget.provider.dsMunicipio}/';
    providerLocation +=
        widget.provider.dsEstado!.isEmpty ? '' : '${widget.provider.dsEstado}';
    if (providerLocation.isEmpty) {
      return GuideProvidersLabels.providerItemEmptyLocation;
    }
    return providerLocation;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Modular.to.pushNamed(
        'providerDetails',
        arguments: {
          'planProviderModel': widget.provider,
        },
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor.withOpacity(0.025),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    scrollDirection: Axis.horizontal,
                    child: Tooltip(
                      message: widget.provider.nmPrestador ?? 'Sem nome',
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        widget.provider.nmPrestador ?? 'Sem nome',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  onPressed: () async {
                    await store.setFavoriteProvider(widget.provider).then(
                      (value) {
                        showInSnackBar(
                          widget.provider.isFavorite!
                              ? GuideProvidersLabels.providerItemEmptySuccessAdd
                              : GuideProvidersLabels.providerItemEmptySuccessRemove,
                          Colors.green,
                        );
                      },
                    ).catchError(
                      (onError) {
                        showInSnackBar(
                          GuideProvidersLabels.providerItemEmptySaveError,
                          Colors.red,
                        );
                      },
                    );
                  },
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    widget.provider.isFavorite!
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            Tooltip(
              message: buildSpecialtiesString(),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: OverflowProofText(
                text: Text(
                  buildSpecialtiesString(),
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: 12,
                      ),
                ),
                fallback: TripleBuilder<ShowMoreStore, Exception, bool>(
                  store: showMoreStore,
                  builder: (_, triple) {
                    if (triple.state) {
                      return Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                              text: buildSpecialtiesString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12,
                                  ),
                            ),
                            const WidgetSpan(
                              child: SizedBox(width: 5),
                            ),
                            WidgetSpan(
                              child: ShowMoreWidget(
                                animationController: animationController,
                                showMoreStore: showMoreStore,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              buildSpecialtiesString(),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 13,
                                  ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          ShowMoreWidget(
                            animationController: animationController,
                            showMoreStore: showMoreStore,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.location_on_rounded,
                  size: 16,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: SelectableText(
                    buildProviderLocationString(),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 10,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showInSnackBar(String value, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.background,
              ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
