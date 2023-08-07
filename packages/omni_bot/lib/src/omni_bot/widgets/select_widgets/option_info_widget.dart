import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_bot_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

class OptionInfoWidget extends StatefulWidget {
  final String? title;
  final String? image;
  final String? subtitle;
  final VoidCallback onPressed;
  final bool isSelected;

  const OptionInfoWidget({
    Key? key,
    this.title,
    this.image,
    this.subtitle,
    this.isSelected = false,
    required this.onPressed,
  }) : super(key: key);

  @override
  _OptionInfoWidgetState createState() => _OptionInfoWidgetState();
}

class _OptionInfoWidgetState extends State<OptionInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            BotLabels.botOptionInfActionDescription,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.black,
                ),
          ),
          const Divider(),
          Flexible(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: 15),
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  if (widget.image != null) _buildImageWidget(context),
                  if (widget.title != null) _buildTitleWidget(context),
                  if (widget.subtitle != null) _buildDescriptionWidget(context),
                ],
              ),
            ),
          ),
          DefaultButtonWidget(
            onPressed: () {
              widget.onPressed();
              Modular.to.pop();
            },
            buttonType: widget.isSelected
                ? DefaultButtonType.primary
                : DefaultButtonType.outline,
            text: widget.isSelected
                ? BotLabels.botOptionInfoUnselect
                : BotLabels.botOptionInfoSelect,
          ),
        ],
      ),
    );
  }

  Widget _buildImageWidget(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).cardColor.withOpacity(0.1),
          ),
          padding: const EdgeInsets.all(5),
          child: ClipOval(
            child: ImageWidget(
              url: widget.image!,
              asset: Assets.test,
              height: 150,
              width: 150,
            ),
          ),
        ),
        const SizedBox(height: 15),
        const Divider(),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildTitleWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          BotLabels.botOptionInfoTitle,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.title ?? BotLabels.botOptionInfoWithoutTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 15),
      ],
    );
  }

  Widget _buildDescriptionWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          BotLabels.botOptionInfoDescription,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
        ),
        const SizedBox(height: 10),
        Text(
          widget.subtitle ?? BotLabels.botOptionInfoWithoutDescription,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
