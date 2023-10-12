import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_core/src/app/modules/terms/terms_store.dart';
import 'package:omni_core/src/app/modules/terms/widgets/terms_item_widget.dart';
import 'package:omni_general/omni_general.dart';
import 'package:terms_labels/labels.dart';

class TermsPage extends StatefulWidget {
  final String programCode;

  const TermsPage({
    Key? key,
    required this.programCode,
  }) : super(key: key);
  @override
  TermsPageState createState() => TermsPageState();
}

class TermsPageState extends State<TermsPage> {
  final TermsStore store = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black54,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Termos',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(15),
            //   child: Text(
            //     TermsLabels.termsRead,
            //     style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            //           color: Theme.of(context).primaryColor,
            //         ),
            //   ),
            // ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TermsItemWidget(
                      onTap: () => Modular.to.pushNamed(
                        'termsOfUse',
                        arguments: widget.programCode,
                      ),
                      title: TermsLabels.termsConditions,
                    ),
                    const Divider(),
                    TermsItemWidget(
                      onTap: () => Modular.to.pushNamed(
                        'privacyPolicies',
                        arguments: widget.programCode,
                      ),
                      title: TermsLabels.termsPrivacy,
                    ),
                    const Divider(),
                    TermsItemWidget(
                      onTap: () => Modular.to.pushNamed(
                        'programContract',
                        arguments: widget.programCode,
                      ),
                      title: TermsLabels.termscontract,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
