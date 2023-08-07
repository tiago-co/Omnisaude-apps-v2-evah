import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/notice_model.dart';
import 'package:omni_core/src/app/modules/notifications/notifications_repository.dart';
import 'package:omni_general/omni_general.dart';

class NoticesStore extends NotifierStore<DioError, NoticeResultsModel>
    with Disposable {
  final NotificationsRepository _repository = Modular.get();
  final QueryParamsModel params = QueryParamsModel();

  NoticesStore() : super(NoticeResultsModel(results: []));

  Future<void> getNotices(QueryParamsModel params) async {
    setLoading(true);
    await _repository.getNotices(params).then((notices) {
      update(notices!);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(onError);
    });
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
