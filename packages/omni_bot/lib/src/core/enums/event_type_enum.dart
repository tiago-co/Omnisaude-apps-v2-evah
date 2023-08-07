import 'package:omni_bot_labels/labels.dart';

enum EventType {
  debug,
  error,
  typing,
  system,
  connected,
  disconnected,
  nluStart,
  nluEnd,
  entryQueue,
  userLeft,
  attendantLeft,
  initAttendance,
  updateQueue,
  finishAttendance,
  authentication,
}

extension EventTypeExtension on EventType {
  String? get label {
    switch (this) {
      case EventType.debug:
        return BotLabels.eventTypeDebug;
      case EventType.error:
        return BotLabels.eventTypeError;
      case EventType.typing:
        return BotLabels.eventTypeTyping;
      case EventType.system:
        return BotLabels.eventTypeSystem;
      case EventType.connected:
        return BotLabels.eventTypeConnected;
      case EventType.disconnected:
        return BotLabels.eventTypeDisconnected;
      case EventType.nluStart:
        return BotLabels.eventTypeNluStart;
      case EventType.nluEnd:
        return BotLabels.eventTypeNluEnd;
      case EventType.entryQueue:
        return BotLabels.eventTypeEntryQueue;
      case EventType.userLeft:
        return BotLabels.eventTypeUserLeft;
      case EventType.attendantLeft:
        return BotLabels.eventTypeAttendantLeft;
      case EventType.initAttendance:
        return BotLabels.eventTypeInitAttendance;
      case EventType.updateQueue:
        return BotLabels.eventTypeUpdateQueue;
      case EventType.finishAttendance:
        return BotLabels.eventTypeFinishAttendance;
      case EventType.authentication:
        return BotLabels.eventTypeAuthentication;
      default:
        return null;
    }
  }

  String? get toJson {
    switch (this) {
      case EventType.debug:
        return 'debug';
      case EventType.error:
        return 'error';
      case EventType.typing:
        return 'typing';
      case EventType.system:
        return 'system';
      case EventType.connected:
        return 'connected';
      case EventType.nluStart:
        return 'nlu_start';
      case EventType.nluEnd:
        return 'nlu_end';
      case EventType.entryQueue:
        return 'entry_queue';
      case EventType.userLeft:
        return 'user_left';
      case EventType.attendantLeft:
        return 'attendant_left';
      case EventType.initAttendance:
        return 'init_attendance';
      case EventType.updateQueue:
        return 'update_queue';
      case EventType.finishAttendance:
        return 'finish_attendance';
      case EventType.authentication:
        return 'authentication';
      default:
        return null;
    }
  }
}

EventType? eventTypeFromJson(String type) {
  switch (type) {
    case 'debug':
      return EventType.debug;
    case 'error':
      return EventType.error;
    case 'typing':
      return EventType.typing;
    case 'system':
      return EventType.system;
    case 'connected':
      return EventType.connected;
    case 'nlu_start':
      return EventType.nluStart;
    case 'nlu_end':
      return EventType.nluEnd;
    case 'entry_queue':
      return EventType.entryQueue;
    case 'user_left':
      return EventType.userLeft;
    case 'attendant_left':
      return EventType.attendantLeft;
    case 'init_attendance':
      return EventType.initAttendance;
    case 'update_queue':
      return EventType.updateQueue;
    case 'finish_attendance':
      return EventType.finishAttendance;
    case 'authentication':
      return EventType.authentication;
    default:
      return null;
  }
}
