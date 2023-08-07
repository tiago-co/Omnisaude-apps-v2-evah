import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/src/core/enums/event_type_enum.dart';
import 'package:omni_bot/src/core/models/bot_message_model.dart';
import 'package:omni_bot/src/core/models/event_model.dart';
import 'package:omni_bot/src/omni_bot/omni_bot_connection.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';

// ignore: must_be_immutable
class OmniBotStore extends NotifierStore<Exception, List<BotMessageModel>>
    with Disposable {
  OmniBotStore() : super(List.generate(1, (index) => BotMessageModel()));

  final String _wssBase = dotenv.env['WSS_URL']!;
  late StreamController _streamController;
  late OmniBotConnection connection;
  String chatUsername = 'Assistente Virtual';
  String? chatAvatar;
  String assetOne = Assets.botOne;
  String assetTwo = Assets.botTwo;
  String assetTree = Assets.botTree;

  Future<void> initSession({
    required String botId,
    required JwtModel jwt,
    required BeneficiaryModel beneficiary,
  }) async {
    connection = OmniBotConnection(
      url: '$_wssBase/ws/chat/$botId/',
      username: beneficiary.individualPerson!.user!.username,
      avatarUrl: beneficiary.individualPerson!.image,
    );
    _streamController = await connection.initSession();
    _streamController.stream.listen(
      (message) async {
        final List<BotMessageModel> messages = List.empty(growable: true);
        state.insert(0, message);
        messages.addAll(state);
        if (message.peer != connection.peer) {
          if (message.peer == 'bot') {
            assetOne = Assets.botOne;
            assetTwo = Assets.botTwo;
            assetTree = Assets.botTree;
            chatAvatar = message.avatarUrl ?? chatAvatar;
            chatUsername = message.username ?? 'Assistente Virtual';
          } else if (message.peer != 'system') {
            assetOne = Assets.attendanceOne;
            assetTwo = Assets.attendanceTwo;
            assetTree = Assets.attendanceTree;
            chatAvatar = message.avatarUrl ?? chatAvatar;
            chatUsername = message.username ?? 'Atendente';
          }
        }
        update(messages);
        if (message.event?.eventType == EventType.authentication) {
          await connection.authenticate(
            userId: jwt.id,
            token: jwt.token,
            cpf: beneficiary.individualPerson!.cpf,
            avatarUrl: beneficiary.individualPerson!.image,
            username: beneficiary.individualPerson!.user!.username,
            metadata: {'KEY': 'VALUE'},
          );
        }
      },
      onError: (onError) {
        final BotMessageModel message = BotMessageModel(
          event: EventModel(
            eventType: EventType.error,
            message: 'Erro de conexão!',
          ),
        );
        state.insert(0, message);
        setError(onError);
        connection.dispose();
      },
      onDone: () {
        state.insert(
          0,
          BotMessageModel(event: EventModel(eventType: EventType.disconnected)),
        );
        setError(Exception(connection.connectionStatus));
        connection.dispose();
      },
      cancelOnError: true,
    );
  }

  @override
  void dispose() {
    _streamController.close();
    connection.dispose();
  }
}
