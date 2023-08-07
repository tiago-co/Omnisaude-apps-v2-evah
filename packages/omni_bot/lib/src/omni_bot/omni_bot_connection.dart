import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_bot/src/core/enums/connection_status_enum.dart';
import 'package:omni_bot/src/core/enums/event_type_enum.dart';
import 'package:omni_bot/src/core/models/bot_message_model.dart';
import 'package:omni_bot/src/core/models/message_model.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class OmniBotConnection extends Disposable {
  final String? url;
  final String? username;
  final String? avatarUrl;
  late String peer;

  OmniBotConnection({
    this.url,
    this.username,
    this.avatarUrl,
  });

  final StreamController<BotMessageModel> _controller = StreamController();
  ConnectionStatus connectionStatus = ConnectionStatus.none;
  late StreamSubscription _subscription;
  late WebSocketChannel _channel;

  Future<StreamController> initSession() async {
    if (url == null) {
      connectionStatus = ConnectionStatus.error;
      _controller.addError(Exception('URL nula'));
      return _controller;
    }
    _channel = WebSocketChannel.connect(Uri.parse(url!));
    connectionStatus = ConnectionStatus.waiting;
    _subscription = _channel.stream.listen(
      (onMessage) async {
        _subscription.pause();
        connectionStatus = ConnectionStatus.active;
        final BotMessageModel _message = BotMessageModel.fromJson(
          jsonDecode(onMessage),
        );
        if (_message.event?.eventType == EventType.connected) {
          peer = _message.event!.message!;
        }
        _controller.sink.add(_message);
        _onMessageReceived(_message);
        await Future.delayed(const Duration(milliseconds: 500));
        _subscription.resume();
      },
      onError: (onError) {
        log('Erro de conexão: $onError');
        connectionStatus = ConnectionStatus.error;
        _controller.addError(onError);
      },
      onDone: () {
        connectionStatus = ConnectionStatus.done;
        dispose();
      },
      cancelOnError: true,
    );
    return _controller;
  }

  void _onMessageReceived(BotMessageModel message) {
    try {
      log('###--> MENSAGEM RECEBIDA: ${message.toJson()}\n');
    } catch (e) {
      log('Erro ao receber mensagem: $e');
    }
  }

  Future<void> authenticate({
    String? cpf,
    String? token,
    String? userId,
    String? username,
    String? avatarUrl,
    Map<String, dynamic>? metadata,
  }) async {
    final BotMessageModel message = BotMessageModel(
      message: MessageModel(
        extras: {
          'cpf': cpf,
          'token': token,
          'name': username,
          'avatar': avatarUrl,
          'metadata': metadata,
          'external_id': userId,
        },
      ),
    );
    await onSendMessage(message);
  }

  Future<void> onSendMessage(BotMessageModel message) async {
    try {
      message.peer = peer;
      message.username = username;
      message.avatarUrl = avatarUrl;
      // message.datetimeFieldValue = FieldValue.serverTimestamp();

      if (connectionStatus == ConnectionStatus.active) {
        _channel.sink.add(jsonEncode(message));
        log('***--> MENSAGEM ENVIADA: ${jsonEncode(message)}\n');
      } else {
        log(
          'Não foi possível enviar a mensagem, pois a conexão está inativa!',
        );
      }
    } catch (e) {
      log('Erro ao enviar mensagem: $e');
    }
  }

  @override
  void dispose() {
    try {
      _channel.sink.close(
        status.normalClosure,
        'Conexão Conexão com o BOT encerrada',
      );
      _channel.sink.close();
      _controller.close();
      _subscription.cancel();
      log('-> Conexão com o BOT encerrada');
    } catch (e) {
      log('Erro ao encerrar conexão com o BOT: $e');
    }
  }
}
