import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:mime/mime.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_core/src/app/modules/profile/profile_store.dart';
import 'package:omni_core/src/app/modules/profile/widgets/profile_image_picker_widget.dart';
import 'package:omni_general/omni_general.dart';

class ProfileImageWidget extends StatefulWidget {
  const ProfileImageWidget({Key? key}) : super(key: key);

  @override
  _ProfileImageWidgetState createState() => _ProfileImageWidgetState();
}

class _ProfileImageWidgetState extends State<ProfileImageWidget> {
  final ProfileStore profileStore = Modular.get();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            GestureDetector(child: Center(child: _buildUserAvatar)),
            Positioned(
              left: MediaQuery.of(context).size.width / 2 + 20,
              bottom: 0,
              child: GestureDetector(
                onTap: () async {
                  await showModalBottomSheet(
                    context: context,
                    enableDrag: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    builder: (_) => ProfileImagePickerWidget(
                      onSelectItem: (File file) async {
                        final String ext = lookupMimeType(file.path) ?? '';
                        final String b64 = UriData.fromBytes(
                          file.readAsBytesSync(),
                          mimeType: ext,
                        ).toString();
                        String url = '';
                        if (profileStore.userStore.beneficiary.individualPerson!
                                .image !=
                            null) {
                          url = profileStore
                              .userStore.beneficiary.individualPerson!.image!;
                          await CachedNetworkImage.evictFromCache(
                            profileStore.state.image!,
                          ).whenComplete(() {
                            profileStore.updateField({'b64': b64});
                          }).catchError((onError) {
                            Helpers.showDialog(
                              context,
                              onError,
                              showClose: true,
                            );
                            profileStore.userStore.beneficiary.individualPerson!
                                .image = url;
                          });
                        }
                        profileStore
                            .updateField({'b64': b64}).catchError((onError) {
                          Helpers.showDialog(
                            context,
                            onError,
                            showClose: true,
                          );
                          profileStore.userStore.beneficiary.individualPerson!
                              .image = url;
                        });
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context)
                        .colorScheme
                        .background
                        .withOpacity(0.85),
                    border: Border.all(
                      color: Theme.of(context).cardColor.withOpacity(0.1),
                      width: 1.5,
                    ),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget get _buildUserAvatar {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(5),
      child: TripleBuilder<UserStore, Exception, PreferencesModel>(
        store: profileStore.userStore,
        builder: (_, triple) {
          return ClipOval(
            child: ImageWidget(
              key: ValueKey(
                triple.state.beneficiary!.individualPerson,
              ),
              url: triple.state.beneficiary!.individualPerson!.image ?? '',
              asset: Assets.user,
              assetBase: Assets.userBase,
              boxFit: BoxFit.cover,
              width: 125,
              height: 125,
            ),
          );
        },
      ),
    );
  }
}
