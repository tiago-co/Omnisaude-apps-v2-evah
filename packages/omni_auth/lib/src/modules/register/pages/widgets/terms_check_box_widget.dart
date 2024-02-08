import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_auth/src/modules/register/stores/register_terms_store.dart';
import 'package:omni_register_labels/labels.dart';

class TermsCheckBoxWidget extends StatefulWidget {
  const TermsCheckBoxWidget({Key? key}) : super(key: key);

  @override
  _TermsCheckBoxWidgetState createState() => _TermsCheckBoxWidgetState();
}

class _TermsCheckBoxWidgetState extends State<TermsCheckBoxWidget> {
  final RegisterTermsStore store = Modular.get();
  @override
  void initState() {
    // store.update(store.registerStore.state.termsAccepted);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Theme.of(context).primaryColor.withOpacity(0.1),
        splashColor: Theme.of(context).primaryColor.withOpacity(0.05),
      ),
      child: TripleBuilder<RegisterTermsStore, Exception, bool>(
        store: store,
        builder: (_, triple) {
          return ExcludeSemantics(
            child: AbsorbPointer(
              absorbing: false,
              child: Opacity(
                opacity: 1 == 0 ? 0.5 : 1.0,
                child: CheckboxListTile(
                  value: triple.state,
                  onChanged: store.onChangeCheckBoxValue,
                  activeColor: Theme.of(context).primaryColor,
                  checkColor: Theme.of(context).colorScheme.background,
                  controlAffinity: ListTileControlAffinity.leading,
                  tileColor: Theme.of(context).cardColor.withOpacity(0.05),
                  contentPadding: EdgeInsets.zero,
                  title: RichText(
                    text: TextSpan(
                      text: RegisterLabels.termsCheckboxAccept,
                      style: Theme.of(context).textTheme.titleLarge,
                      children: [
                        TextSpan(
                          text: RegisterLabels.termsCheckboxCoditions,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Modular.to.pushNamed(
                                '/terms',
                                // arguments:
                                //     store.registerStore.state.programCode,
                              );
                            },
                        ),
                        const TextSpan(text: RegisterLabels.termsCheckboxProgram),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
