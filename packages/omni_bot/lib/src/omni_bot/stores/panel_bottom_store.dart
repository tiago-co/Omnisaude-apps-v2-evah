import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/src/core/enums/event_type_enum.dart';
import 'package:omni_bot/src/core/enums/panel_bottom_type.dart';
import 'package:omni_bot/src/core/models/bot_message_model.dart';

// ignore: must_be_immutable
class PanelBottomStore extends NotifierStore<Exception, PanelBottomType> {
  PanelBottomStore() : super(PanelBottomType.none);

  bool nluEnabled = false;
  bool attendanceEnabled = false;

  void onChangeType(BotMessageModel botMessage) {
    if (botMessage.event != null) {
      switch (botMessage.event!.eventType) {
        case EventType.nluStart:
          nluEnabled = true;
          break;
        case EventType.nluEnd:
          nluEnabled = false;
          break;
        case EventType.attendantLeft:
          break;
        case EventType.initAttendance:
          attendanceEnabled = true;
          break;
        case EventType.finishAttendance:
          attendanceEnabled = false;
          break;
        default:
          break;
      }
    }

    if (nluEnabled || attendanceEnabled) {
      update(PanelBottomType.panel);
    } else if (!nluEnabled && !attendanceEnabled) {
      update(PanelBottomType.none);
    }

    if (botMessage.input != null || botMessage.upload != null) {
      update(PanelBottomType.panel);
    } else if (botMessage.select != null) {
      update(PanelBottomType.select);
    }
  }
}
