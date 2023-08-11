import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_assistance_labels/labels.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({Key? key}) : super(key: key);

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int nom = 3;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Como foi sua experiência?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      Assets.close,
                      package: AssetsPackage.omniGeneral,
                      color: Theme.of(context).primaryColor,
                      width: 30,
                      height: 30,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 75,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => setState(() {
                      nom = index;
                    }),
                    child: Icon(
                      index <= nom ? Icons.star : Icons.star_border_outlined,
                      color: Colors.amber,
                      size: 40,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              // focusNode: noteNode,
              autofocus: true,
              onChanged: (String? input) {
                // store.state.note = input;
                // store.update(store.state);
              },
              onFieldSubmitted: (input) {
                // if (_formKey.currentState!.validate()) {
                //   store.createAssistance();
                // }
              },
              validator: (String? input) {
                if (input == null || input.isEmpty) {
                  return AssistanceLabels.createAssistanceEmptyField;
                }
                return null;
              },

              decoration: InputDecoration(
                labelText: 'Descrição',
                hintText: 'Conte-nos o porquê desta nota...',
                hintStyle: Theme.of(context).textTheme.titleLarge,
                labelStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).cardColor.withOpacity(0.75),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).cardColor.withOpacity(0.75),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).cardColor.withOpacity(0.75),
                  ),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).cardColor.withOpacity(0.75),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Salvar",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
