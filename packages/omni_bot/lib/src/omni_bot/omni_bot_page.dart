import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/src/core/enums/connection_status_enum.dart';
import 'package:omni_bot/src/core/models/bot_message_model.dart';
import 'package:omni_bot/src/omni_bot/stores/omni_bot_store.dart';
import 'package:omni_bot/src/omni_bot/widgets/panel_send_message_widget.dart';
import 'package:omni_bot/src/omni_bot/widgets/render_message_widget.dart';
import 'package:omni_bot_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

class OmniBotPage extends StatefulWidget {
  final String title;
  final String botId;
  final JwtModel jwt;
  final BeneficiaryModel beneficiary;

  const OmniBotPage({
    Key? key,
    required this.title,
    required this.botId,
    required this.jwt,
    required this.beneficiary,
  }) : super(key: key);

  @override
  _OmniBotPageState createState() => _OmniBotPageState();
}

class _OmniBotPageState extends State<OmniBotPage>
    with SingleTickerProviderStateMixin {
  final OmniBotStore store = Modular.get();
  final Duration duration = const Duration(milliseconds: 250);
  late AnimationController animationController;
  late Animation<double> animation1;
  late Animation<double> animation2;

  final ScrollController scrollController = ScrollController();
  final GlobalKey headerKey = GlobalKey();

  @override
  void initState() {
    log(widget.botId);
    animationController = AnimationController(vsync: this, duration: duration);
    animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      animationController,
    );
    animation2 = Tween<double>(begin: 1.0, end: 0.0).animate(
      animationController,
    );
    store.initSession(
      botId: widget.botId,
      jwt: widget.jwt,
      beneficiary: widget.beneficiary,
    );
    scrollController.addListener(() {
      // getOffset(headerKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    store.dispose();
    scrollController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white.withOpacity(0.99),
      child: Scaffold(
        appBar: NavBarWidget(
          title: widget.title,
          leadingType: LeadingType.close,
        ).build(context) as AppBar,
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          child: Column(
            children: [
              TripleBuilder<OmniBotStore, Exception, List<BotMessageModel>>(
                store: store,
                builder: (_, triple) {
                  return AnimatedBuilder(
                    animation: animationController,
                    builder: (_, child) {
                      return FadeTransition(
                        opacity: animation1,
                        child: SizeTransition(
                          sizeFactor: animation1,
                          child: _buildNavHeaderWidget,
                        ),
                      );
                    },
                  );
                },
              ),
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [_buildFloatingHeaderWidget, _buildMessageList],
                  ),
                ),
              ),
              TripleBuilder<OmniBotStore, Exception, List<BotMessageModel>>(
                store: store,
                builder: (_, triple) {
                  return PanelSendMessageWidget(
                    botMessage: triple.state.first,
                    connection: store.connection,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildNavHeaderWidget {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).cardColor.withOpacity(0.25),
            width: 0.5,
          ),
        ),
        color: Theme.of(context).colorScheme.background,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor.withOpacity(0.05),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).cardColor.withOpacity(0.1),
              ),
              padding: const EdgeInsets.all(2.5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipOval(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.background,
                      ),
                      child: store.chatAvatar != null
                          ? ImageWidget(
                              url: store.chatAvatar!,
                              boxFit: BoxFit.cover,
                            )
                          : _buildChatAssetWidget,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    Formaters.capitalize(store.chatUsername),
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                  ),
                  const SizedBox(height: 5),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    child: Tooltip(
                      message: widget.title,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: const EdgeInsets.all(10),
                      preferBelow: true,
                      child: Text(
                        widget.title,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color:
                    store.connection.connectionStatus == ConnectionStatus.active
                        ? Colors.green.withOpacity(0.1)
                        : Colors.red.withOpacity(0.1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: store.connection.connectionStatus ==
                              ConnectionStatus.active
                          ? Colors.green
                          : Colors.red,
                    ),
                    height: 7.5,
                    width: 7.5,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    store.connection.connectionStatus == ConnectionStatus.active
                        ? BotLabels.botConnectionActive
                        : BotLabels.botConnectionInactive,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 12,
                          color: store.connection.connectionStatus ==
                                  ConnectionStatus.active
                              ? Colors.green
                              : Colors.red,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildChatAssetWidget {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: SvgPicture.asset(
              store.assetOne,
              package: AssetsPackage.omniBot,
              fit: BoxFit.cover,
              color: Theme.of(context).cardColor,
            ),
          ),
          Center(
            child: SvgPicture.asset(
              store.assetTwo,
              package: AssetsPackage.omniBot,
              fit: BoxFit.cover,
              color: Theme.of(context).primaryColor,
            ),
          ),
          Center(
            child: SvgPicture.asset(
              store.assetTree,
              package: AssetsPackage.omniBot,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildFloatingHeaderWidget {
    return TripleBuilder<OmniBotStore, Exception, List<BotMessageModel>>(
      key: headerKey,
      store: store,
      builder: (_, triple) {
        if (store.connection.connectionStatus == ConnectionStatus.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const LoadingWidget(),
                const SizedBox(height: 15),
                Text(
                  BotLabels.botLoadingMessage,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          );
        }
        return AnimatedBuilder(
          animation: animationController,
          builder: (_, child) {
            return FadeTransition(
              opacity: animation2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.15,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor.withOpacity(0.1),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: ClipOval(
                        child: ColoredBox(
                          color: Theme.of(context).colorScheme.background,
                          child: store.chatAvatar != null
                              ? ImageWidget(
                                  url: store.chatAvatar!,
                                  boxFit: BoxFit.cover,
                                  width: 150,
                                  height: 150,
                                )
                              : _buildChatAssetWidget,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(5),
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '${BotLabels.botChattingWith}'
                      '${Formaters.capitalize(store.chatUsername)}.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Divider(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget get _buildMessageList {
    return TripleBuilder<OmniBotStore, Exception, List<BotMessageModel>>(
      store: store,
      builder: (_, triple) {
        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          itemCount: triple.state.length,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          itemBuilder: (_, index) {
            return RenderMessageWidget(
              key: ObjectKey(triple.state[index]),
              botMessage: triple.state[index],
              lastBotMessage: triple.state.last,
              connection: store.connection,
              nameBot: widget.title,
            );
          },
        );
      },
    );
  }
}
