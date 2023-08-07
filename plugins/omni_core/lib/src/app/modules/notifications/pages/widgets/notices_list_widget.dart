import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:notifications_labels/labels.dart';
import 'package:omni_core/src/app/core/models/notice_model.dart';
import 'package:omni_core/src/app/modules/notifications/pages/widgets/notice_item_shimmer_widget.dart';
import 'package:omni_core/src/app/modules/notifications/pages/widgets/notice_item_widget.dart';
import 'package:omni_core/src/app/modules/notifications/stores/notices_store.dart';
import 'package:omni_general/omni_general.dart';

class NoticesListWidget extends StatefulWidget {
  final ScrollController noticeController;

  const NoticesListWidget({
    Key? key,
    required this.noticeController,
  }) : super(key: key);

  @override
  _NoticesListWidgetState createState() => _NoticesListWidgetState();
}

class _NoticesListWidgetState extends State<NoticesListWidget> {
  final NoticesStore store = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Text(
            NotificationsLabels.noticesListNews,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        TripleBuilder<NoticesStore, DioError, NoticeResultsModel>(
          store: store,
          builder: (_, triple) {
            if (triple.isLoading && triple.state.results!.isEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: SizedBox(height: 2.5),
                  ),
                  NoticeItemShimmerWidget(),
                ],
              );
            }
            if (triple.event == TripleEvent.error) {
              return RequestErrorWidget(
                error: triple.error,
                onPressed: () {
                  store.getNotices(store.params);
                },
              );
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!triple.isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: SizedBox(height: 2.5),
                  ),
                if (triple.isLoading && triple.state.results!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 5,
                    ),
                    child: LinearProgressIndicator(
                      minHeight: 2.5,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                if (triple.state.results!.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                    ),
                    child: EmptyWidget(
                      message: NotificationsLabels.noticesListEmpty,
                      isLoading: triple.isLoading,
                    ),
                  ),
                if (triple.state.results!.isNotEmpty)
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    controller: widget.noticeController,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        triple.state.results!.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(left: index == 0 ? 0 : 15),
                          child: AbsorbPointer(
                            absorbing: triple.isLoading,
                            child: Opacity(
                              opacity: triple.isLoading ? 0.5 : 1.0,
                              child: NoticeItemWidget(
                                notice: triple.state.results![index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
