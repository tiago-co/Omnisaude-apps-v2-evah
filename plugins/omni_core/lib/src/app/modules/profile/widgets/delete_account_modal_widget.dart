import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:profile_labels/labels.dart';

class DeleteAccountModalWidget extends StatefulWidget {
  const DeleteAccountModalWidget({Key? key}) : super(key: key);

  @override
  State<DeleteAccountModalWidget> createState() =>
      _DeleteAccountModalWidgetState();
}

class _DeleteAccountModalWidgetState extends State<DeleteAccountModalWidget> {
  UserStore userStore = Modular.get();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      const Icon(
                        Icons.warning_rounded,
                        color: Colors.amber,
                        size: 45,
                      ),
                      Text(
                        ProfileLabels.deleteAccountConfirm,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        ProfileLabels.deleteAccountWantDelete,
                        style: Theme.of(context).textTheme.headlineSmall,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      Text(
                        ProfileLabels.deleteAccountDescription,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Colors.red,
                            ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 25),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {
                                    userStore.deleteUser();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      ProfileLabels.deleteAccountExclude,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: Colors.white,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: DefaultButtonWidget(
                                  buttonType: DefaultButtonType.outline,
                                  text: ProfileLabels.deleteAccountCancel,
                                  onPressed: () {
                                    Modular.to.pop();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
