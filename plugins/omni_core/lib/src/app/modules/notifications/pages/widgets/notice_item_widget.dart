import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:notifications_labels/labels.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/core/models/notice_model.dart';
import 'package:omni_general/omni_general.dart';

class NoticeItemWidget extends StatelessWidget {
  final NoticeModel notice;

  const NoticeItemWidget({Key? key, required this.notice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () async {
                  await Navigator.push(
                    context,
                    PageRouteBuilder(
                      opaque: false,
                      fullscreenDialog: true,
                      transitionDuration: const Duration(milliseconds: 250),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        animation = Tween(begin: 0.0, end: 1.0).animate(
                          animation,
                        );
                        return FadeTransition(
                          opacity: animation,
                          child: _buildNoticeDetailsWidget(context),
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(2.5),
                  height: 100,
                  width: 100,
                  child: ClipOval(
                    child: AbsorbPointer(
                      child: ImageWidget(
                        url: notice.banner ?? '',
                        asset: Assets.notificationOne,
                        assetBase: Assets.notificationTwo,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                notice.title ?? NotificationsLabels.noticeItemTitlePlaceholder,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeDetailsWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).colorScheme.background,
        backgroundColor: Colors.black,
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.06,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ColoredBox(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  child: AbsorbPointer(
                    child: ImageWidget(
                      url: notice.image ?? '',
                      asset: Assets.notificationOne,
                      assetBase: Assets.notificationTwo,
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildNoticeHeaderInfoWidget(context),
          DraggableScrollableSheet(
            initialChildSize: 0.1,
            minChildSize: 0.1,
            expand: false,
            builder: (_, scrollController) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  color: Colors.black.withOpacity(0.85),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SingleChildScrollView(
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  width: 50,
                                  height: 5,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          controller: scrollController,
                          child: Html(
                            data: notice.content ??
                                NotificationsLabels
                                    .noticeItemContentPlaceholder,
                            style: {
                              'html': Style(
                                  // margin: EdgeInsets.zero,
                                  ),
                              'body': Style(
                                // margin: EdgeInsets.zero,
                                color: Colors.white,
                              ),
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeHeaderInfoWidget(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.35),
                Colors.black.withOpacity(0.15),
                Colors.transparent,
              ],
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipOval(
                child: AbsorbPointer(
                  child: ImageWidget(
                    url: notice.banner ?? '',
                    asset: Assets.notificationOne,
                    assetBase: Assets.notificationTwo,
                    boxFit: BoxFit.cover,
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              GestureDetector(
                onTap: () => Modular.to.pop(),
                child: ColoredBox(
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    Assets.close,
                    package: AssetsPackage.omniGeneral,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
