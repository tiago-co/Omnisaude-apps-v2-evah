import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/rating_form_model.dart';
import 'package:omni_core/src/app/shared/widgets/rating_dialog/store/rating_store.dart';
import 'package:omni_core/src/app/shared/widgets/rating_dialog/widgets/accept_contact_checkbox.dart';
import 'package:omni_core/src/app/shared/widgets/rating_dialog/widgets/description_field.dart';
import 'package:omni_core/src/app/shared/widgets/rating_dialog/widgets/rating_value.dart';
import 'package:omni_general/omni_general.dart';

class RatingDialog extends StatefulWidget {
  RatingDialog({Key? key, required this.module}) : super(key: key);
  final String module;

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  late final RatingStore store;
  @override
  void initState() {
    store = RatingStore(RatingFormModel(module: widget.module));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Container(
        color: Theme.of(context).colorScheme.background,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            Text(
              'Em uma escala de 0 a 10, qual a probabilidade de indicar a/o ${store.convertModuleName(widget.module)} para um amigo ou familiar?',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontSize: 14),
            ),
            const SizedBox(height: 15),
            SizedBox(
              height: 35,
              child: RatingValue(store: store),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pouco provável',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Muito provável',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 15),
            DescriptionField(store: store),
            const SizedBox(height: 15),
            AcceptContactCheckbox(store: store),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Fechar',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    TripleBuilder<RatingStore, Exception, RatingFormModel>(
                      store: store,
                      builder: (_, triple) {
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(
                                color: Theme.of(context).primaryColor,
                                width: 0.5,
                              ),
                            ),
                          ),
                          onPressed: () async {
                            await store.postForm();
                            Modular.to.pop();
                          },
                          child: SizedBox(
                            width: 50,
                            height: 20,
                            child: triple.isLoading
                                ? const FittedBox(
                                    fit: BoxFit.fitHeight,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 1.5,
                                    ),
                                  )
                                : Text(
                                    'Enviar',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
