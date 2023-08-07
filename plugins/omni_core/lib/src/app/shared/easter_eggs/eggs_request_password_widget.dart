import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:omni_core/src/app/core/resources/assets.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_labels/labels.dart';

class EggsRequestPasswordWidget extends StatefulWidget {
  final String environmentPassword;

  const EggsRequestPasswordWidget({
    Key? key,
    required this.environmentPassword,
  }) : super(key: key);

  @override
  _EggsRequestPasswordWidgetState createState() =>
      _EggsRequestPasswordWidgetState();
}

class _EggsRequestPasswordWidgetState extends State<EggsRequestPasswordWidget> {
  TextEditingController textController = TextEditingController();

  late final StreamController<ErrorAnimationType>? errorController;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      backgroundColor:
          Theme.of(context).colorScheme.background.withOpacity(0.95),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SafeArea(
          child: ColoredBox(
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    SharedLabels.eggsRequestPasswordInsertCode,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1 + 15,
                    vertical: 50,
                  ),
                  child: _buildPinCodeWidget,
                ),
                Expanded(child: _buildKeyboardGridWidget),
                _buildCancelButtonWidget,
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildPinCodeWidget {
    return AbsorbPointer(
      child: PinCodeTextField(
        length: 6,
        textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 11,
            ),
        obscureText: true,
        appContext: context,
        obscuringCharacter: ' ',
        obscuringWidget: SvgPicture.asset(
          Assets.close,
          package: AssetsPackage.omniGeneral,
          color: Theme.of(context).colorScheme.background,
          height: 5,
          width: 5,
        ),
        blinkWhenObscuring: true,
        animationType: AnimationType.scale,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.circle,
          errorBorderColor: Colors.black,
          borderWidth: 1.5,
          fieldHeight: 20,
          fieldWidth: 20,
          selectedColor: Colors.transparent,
          selectedFillColor: Colors.transparent,
          inactiveFillColor: Colors.transparent,
          activeColor: Theme.of(context).cardColor,
          inactiveColor: Theme.of(context).cardColor,
          disabledColor: Theme.of(context).cardColor,
          activeFillColor: Theme.of(context).cardColor,
        ),
        cursorColor: Colors.black,
        animationDuration: const Duration(milliseconds: 500),
        enableActiveFill: true,
        enablePinAutofill: false,
        errorAnimationController: errorController,
        controller: textController,
        keyboardType: TextInputType.number,
        onCompleted: (String input) {
          if (input != widget.environmentPassword) {
            errorController!.add(ErrorAnimationType.shake);
            Future.delayed(const Duration(milliseconds: 500)).then((value) {
              textController.clear();
            });
          } else {
            Modular.to.pop(true);
          }
        },
        onChanged: (String value) {},
      ),
    );
  }

  Widget get _buildKeyboardGridWidget {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.1,
      ),
      children: [
        _buildKeyboardItemWidget('1'),
        _buildKeyboardItemWidget('2', alph: 'D E F'),
        _buildKeyboardItemWidget('3', alph: 'G H I'),
        _buildKeyboardItemWidget('4', alph: 'J K L'),
        _buildKeyboardItemWidget('5', alph: 'M N O'),
        _buildKeyboardItemWidget('6', alph: 'P Q R S'),
        _buildKeyboardItemWidget('7', alph: 'T U V'),
        _buildKeyboardItemWidget('8', alph: 'W X Y Z'),
        _buildKeyboardItemWidget('9', alph: 'A B C'),
        const SizedBox(),
        _buildKeyboardItemWidget('0', isLast: true),
        _buildDeleteWidget,
      ],
    );
  }

  Widget _buildKeyboardItemWidget(
    String label, {
    String? alph,
    bool isLast = false,
  }) {
    return ClipOval(
      child: ColoredBox(
        color: Theme.of(context).cardColor.withOpacity(0.75),
        child: InkWell(
          splashColor: Colors.black,
          highlightColor: Colors.black.withOpacity(0.75),
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            if (textController.text.length >= 6) return;
            textController.text += label;
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 25,
                    ),
              ),
              if (!isLast)
                Text(
                  alph ?? '',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 10,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildDeleteWidget {
    return ClipOval(
      child: ColoredBox(
        color: Theme.of(context).cardColor.withOpacity(0.75),
        child: InkWell(
          splashColor: Colors.black,
          highlightColor: Colors.black.withOpacity(0.75),
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            if (textController.text.isEmpty) return;
            final List<String> code = textController.text.split('');
            textController.text = code.sublist(0, code.length - 1).join();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.backspace, color: Colors.white, size: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildCancelButtonWidget {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.1 + 15,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: TextButton(
          onPressed: () => Modular.to.pop(false),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            overlayColor: MaterialStateProperty.all(
              Theme.of(context).primaryColor.withOpacity(0.05),
            ),
          ),
          child: Text(
            SharedLabels.eggsRequestPasswordCancel,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
