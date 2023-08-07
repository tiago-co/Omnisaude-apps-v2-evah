import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:presentation_labels/labels.dart';

class PresentationPage extends StatefulWidget {
  const PresentationPage({Key? key}) : super(key: key);

  @override
  _PresentationPageState createState() => _PresentationPageState();
}

class _PresentationPageState extends State<PresentationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(flex: 7, child: _buildBackgroudImageBody),
              const Expanded(flex: 3, child: SizedBox()),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: _buildButtonsBody,
          ),
        ],
      ),
    );
  }

  Widget get _buildBackgroudImageBody {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          alignment: Alignment.center,
          child: SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.asset(
                    Assets.oldPresentation,
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    colorBlendMode: BlendMode.color,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                child: SvgPicture.asset(
                  Assets.logoPresentation,
                  height: 128,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget get _buildButtonsBody {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Theme.of(context).colorScheme.background,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.15,
        vertical: 15,
      ),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.4,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              PresentationLabels.presentationWelcome,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              PresentationLabels.presentationWhatToDo,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(height: 25),
            DefaultButtonWidget(
              onPressed: () {
                Modular.to.pushNamed('/auth/login');
              },
              text: PresentationLabels.presentationEnter,
            ),
            //TODO deve ser descomentado este bloco para**
            //TODO gerar qualquer app menos o app evah
            const SizedBox(height: 15),
            Text(
              PresentationLabels.presentationOr,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            const SizedBox(height: 15),
            DefaultButtonWidget(
              onPressed: () {
                Navigator.pushNamed(context, '/auth/register');
              },
              buttonType: DefaultButtonType.outline,
              text: PresentationLabels.presentationRegister,
            ),
          ],
        ),
      ),
    );
  }
}
