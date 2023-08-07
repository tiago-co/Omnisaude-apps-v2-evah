import 'package:flutter_triple/flutter_triple.dart';

// ignore: must_be_immutable
class DateTimePickerStore extends NotifierStore<Exception, List<DateTime>> {
  DateTimePickerStore() : super([]);

  DateTime? dateTime;
  bool canRequest = false;

  Future<void> getBlackoutDates(
    Map<String, dynamic> args,
    Future<List<DateTime>?> Function(Map<String, dynamic> args) onChangeView,
  ) async {
    if (!canRequest) {
      canRequest = true;
      return;
    }
    setLoading(true);
    await onChangeView(args).then((blackoutDates) {
      update(blackoutDates!);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(Exception(onError));
    });
  }

  void updateDateTime(DateTime? newDateTime) {
    setLoading(true);
    dateTime = newDateTime;
    setLoading(false);
  }

  bool get isDisabled => dateTime == null;
}
