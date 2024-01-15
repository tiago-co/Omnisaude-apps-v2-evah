import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_auth/src/modules/new_login/store/new_login_store.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general/src/core/models/new_credential_model.dart';

class SaveDataDialog extends StatelessWidget {
  SaveDataDialog({Key? key, required this.state}) : super(key: key);

  final NewCredentialModel state;
  final PreferencesService preferencesService = PreferencesService();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Text(
            'Deseja salvar as informações de login para a próxima vez que retornar?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                onPressed: () {
                  preferencesService.clear();
                  Modular.to.pop();
                },
                child: Text(
                  'Não',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 0.5,
                    ),
                  ),
                ),
                onPressed: () async {
                  await preferencesService.setCredential(state);
                  Modular.to.pop();
                },
                child: SizedBox(
                  height: 20,
                  child: Text(
                    'Sim',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
