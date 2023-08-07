import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:profile_labels/labels.dart';

class ProfileImagePickerWidget extends StatefulWidget {
  final Function onSelectItem;
  final bool active;
  const ProfileImagePickerWidget({
    Key? key,
    required this.onSelectItem,
    this.active = true,
  }) : super(key: key);

  @override
  _ProfileImagePickerWidgetState createState() =>
      _ProfileImagePickerWidgetState();
}

class _ProfileImagePickerWidgetState extends State<ProfileImagePickerWidget> {
  final FilePickerService service = FilePickerService();

  Future<void> openGallery() async {
    await service.openGallery().then((file) {
      if (file == null) return;
      widget.onSelectItem(file);
    });
  }

  Future<void> openCamera() async {
    await service.openCamera().then((file) {
      if (file == null) return;
      widget.onSelectItem(file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.active ? 1.0 : 0.25,
      child: AbsorbPointer(
        absorbing: !widget.active,
        child: _buildSelectSheetWidget,
      ),
    );
  }

  Widget get _buildSelectSheetWidget {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Theme.of(context).colorScheme.background,
      ),
      margin: const EdgeInsets.only(top: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: BottomSheetHeaderWidget(
              title: ProfileLabels.profileImagePickerTitle,
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ListView.separated(
                itemCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                separatorBuilder: (_, index) => const Divider(height: 0),
                itemBuilder: (_, index) {
                  switch (index) {
                    case 0:
                      return _buildSelectItemWidget(
                        ProfileLabels.profileImagePickerGalery,
                        openGallery,
                        Icons.image_outlined,
                      );
                    case 1:
                      return _buildSelectItemWidget(
                        ProfileLabels.profileImagePickerCamera,
                        openCamera,
                        Icons.camera_alt_outlined,
                      );
                    default:
                      return const SizedBox();
                  }
                },
              ),
            ),
          ),
          BottomButtonWidget(
            onPressed: () => Modular.to.pop(),
            buttonType: BottomButtonType.outline,
            text: ProfileLabels.profileImagePickerCancel,
          ),
        ],
      ),
    );
  }

  Widget _buildSelectItemWidget(String label, Function onTap, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        enableFeedback: true,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          onTap();
          Navigator.pop(context);
        },
        minVerticalPadding: 0,
        visualDensity: VisualDensity.compact,
        title: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: Text(
            label,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minLeadingWidth: 0,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
