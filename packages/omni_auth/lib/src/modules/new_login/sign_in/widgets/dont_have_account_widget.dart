import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DontHaveAccountWidget extends StatelessWidget {
  const DontHaveAccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Modular.to.pushReplacementNamed('/auth/signUp/');
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 1.5,
              color: Color(0xff000000),
            ),
            children: [
              TextSpan(
                text: 'Não possui conta?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.6000000238,
                  color: Color(0xff1a1c22),
                ),
              ),
              TextSpan(
                text: ' ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Color(0xff2d72b3),
                ),
              ),
              TextSpan(
                text: 'Cadastre-se',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                  color: Color(0xff2d72b3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
