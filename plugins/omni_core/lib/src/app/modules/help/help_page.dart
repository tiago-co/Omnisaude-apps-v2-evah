import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:help_labels/labels.dart';
import 'package:omni_core/src/app/modules/help/help_store.dart';
import 'package:omni_core/src/app/modules/help/widgets/faq_item_widget.dart';
import 'package:omni_general/omni_general.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);
  @override
  HelpPageState createState() => HelpPageState();
}

class HelpPageState extends State<HelpPage> {
  final HelpStore store = Modular.get();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: HelpLabels.helpTitle,
      ).build(context) as AppBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: ColoredBox(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFieldWidget(
                  label: HelpLabels.helpSearchLabel,
                  placeholder: HelpLabels.helpSearchPlaceholder,
                  controller: TextEditingController(),
                ),
              ),
              const SizedBox(height: 5),
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
                    onRefresh: () async {},
                    child: Scrollbar(
                      controller: scrollController,
                      child: ListView.builder(
                        itemCount: 20,
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        itemBuilder: (_, index) {
                          return SafeArea(
                            bottom: index == 19,
                            child: FAQItemWidget(
                              scrollController: scrollController,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
