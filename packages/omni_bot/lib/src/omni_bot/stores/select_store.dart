import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_bot/src/core/models/bot_message_model.dart';
import 'package:omni_bot/src/core/models/message_model.dart';
import 'package:omni_bot/src/core/models/option_model.dart';
import 'package:omni_bot/src/core/models/selected_options_model.dart';
import 'package:omni_bot/src/omni_bot/omni_bot_connection.dart';

import 'package:omni_bot/src/omni_bot/stores/omni_bot_store.dart';

class SelectStore extends NotifierStore<Exception, SelectedOptionsModel> {
  SelectStore()
      : super(
          SelectedOptionsModel(
            selectedOptions: List.empty(growable: true),
          ),
        );

  final OmniBotStore store = Modular.get<OmniBotStore>();
  final List<OptionModel> optionsSelected = List.empty(growable: true);
  final List<OptionModel> filteredOptions = List.empty(growable: true);

  void onSelectOption(OptionModel option) {
    if (state.selectedOptions!.contains(option)) {
      state.selectedOptions!.removeWhere((element) => option.id == element.id);
      optionsSelected.removeWhere((element) => option.id == element.id);
    } else if (state.max != null &&
        state.selectedOptions!.length < state.max!) {
      state.selectedOptions!.add(option);
      optionsSelected.add(option);
    }
    final List<OptionModel> options = List.from(state.selectedOptions!);
    state.selectedOptions = options;
    update(SelectedOptionsModel.fromJson(state.toJson()), force: true);
  }

  Future<void> onSendOptions(
    List<OptionModel> options,
    OmniBotConnection connection,
  ) async {
    final List<String> selectedOptions = List.from(options.map((e) => e.id));
    final MessageModel message = MessageModel(
      extras: {
        'options': selectedOptions,
      },
    );
    final BotMessageModel botMessage = BotMessageModel(message: message);
    await connection.onSendMessage(botMessage);
    optionsSelected.clear();
    state.selectedOptions = List.empty(growable: true);
    update(SelectedOptionsModel.fromJson(state.toJson()));
  }

  void searchOptionByText(String text, List<OptionModel> options) {
    setLoading(true);
    filteredOptions.clear();
    options.forEach(
      (OptionModel option) {
        if (option.title!.toLowerCase().contains(text.toLowerCase()) ||
            (option.subtitle != null
                ? option.subtitle!.toLowerCase().contains(text.toLowerCase())
                : option.subtitle != null)) {
          filteredOptions.add(option);
        }
      },
    );
    setLoading(false);
  }

  bool isDisabled(int min, {int? max}) {
    if (max != null) {
      return optionsSelected.length < min || optionsSelected.length > max;
    }
    return optionsSelected.length < min;
  }

  bool reachedMaxOptions() {
    if (state.max == null) {
      return false;
    } else {
      log('max ${state.max}');
      return state.selectedOptions!.length >= state.max!;
    }
  }

  void updateState(SelectedOptionsModel selectedOption) {
    update(selectedOption);
  }

  void showMaxSelectionReachedSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    final String label = state.max! > 1 ? 'opções' : 'opção';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: const Color(0xFFDEDEDE),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Text(
          'É possível selecionar apenas '
          '${state.max!} $label!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Colors.black,
              ),
        ),
      ),
    );
  }

  bool isActive(OptionModel option) =>
      state.selectedOptions!.any((obj) => obj.id == option.id);
}
