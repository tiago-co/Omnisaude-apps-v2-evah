import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/src/app/core/models/new_exam_model.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:omni_core/src/app/modules/exams/stores/exam_store.dart';

class ExamsItemWidget extends StatefulWidget {
  final NewExamModel exams;

  const ExamsItemWidget({
    Key? key,
    required this.exams,
  }) : super(key: key);

  @override
  State<ExamsItemWidget> createState() => _ExamsItemWidgetState();
}

class _ExamsItemWidgetState extends State<ExamsItemWidget> {
  final ExamStore store = Modular.get();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed('exam_details', arguments: widget.exams);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).cardColor.withOpacity(0.3),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const SizedBox(width: 10),
            SvgPicture.asset(
              Assets.exams,
              package: AssetsPackage.omniGeneral,
              color: Theme.of(context).primaryColor,
              width: 25,
              height: 25,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.exams.name!,
                    overflow: TextOverflow.ellipsis,
                    style:
                        Theme.of(context).textTheme.headlineSmall!.copyWith(),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(
              Assets.arrowRight,
              color: Theme.of(context).primaryColor,
              package: AssetsPackage.omniGeneral,
            ),
            const SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
