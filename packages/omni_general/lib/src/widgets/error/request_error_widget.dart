import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_general_labels/labels.dart';

class RequestErrorWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final DioError? error;
  final String message;

  const RequestErrorWidget({
    Key? key,
    this.buttonText = 'Tentar novamente',
    this.onPressed,
    this.message = '',
    this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 15),
          Text(
            GeneralLabels.requestErrorSomethingWrong,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: BuildAssetsWidget(
              message: _messageErrorWidget(context),
              assetBase: Assets.erroOne,
              asset: Assets.erroTwo,
              boxFit: BoxFit.contain,
              width: 10.5,
            ),
          ),
          if (onPressed != null) const SizedBox(height: 15),
          if (onPressed != null)
            DefaultButtonWidget(
              onPressed: onPressed,
              buttonType: DefaultButtonType.outline,
              text: buttonText,
            )
        ],
      ),
    );
  }

  Widget _messageErrorWidget(BuildContext context) {
    String errorMessage = message;
    String messageErrors = '';
    switch (error?.response?.statusCode) {
      case 400:
        // messageErrors = error!.response!.statusMessage!;
        final Map<String, dynamic>? errors = error!.response!.data['errors'];
        errors?.forEach((key, value) {
          if (value == null) return;
          messageErrors += '* $key: $value\n';
        });
        errorMessage = GeneralLabels.requestError400;
        break;
      case 401:
        if (error!.response!.statusMessage!.contains('Unauthorized')) {
          errorMessage = GeneralLabels.requestUnauthorizedError401;
        } else {
          errorMessage = GeneralLabels.requestExpiredError401;
        }
        break;
      case 403:
        final Map<String, dynamic>? errors = error!.response!.data['errors'];
        errors?.forEach((key, value) {
          if (value == null) return;
          if (value == 'Unauthorized user') {
            errorMessage = GeneralLabels.requestErrorUnauthorizedUser;
          } else if (key == '') {
            errorMessage = value;
          } else {
            errorMessage = GeneralLabels.requestError403;
          }
        });
        break;
      case 404:
        errorMessage = GeneralLabels.requestError404;
        break;
      case 405:
        errorMessage = GeneralLabels.requestError405;
        break;
      case 500:
        errorMessage = GeneralLabels.requestError500;
        break;
      case 502:
        errorMessage = GeneralLabels.requestError502;
        break;
      case 503:
        errorMessage = GeneralLabels.requestError503;
        break;
      default:
        break;
    }

    switch (error?.type) {
      case DioErrorType.connectTimeout:
        errorMessage = GeneralLabels.requestErrorDioErrorConnectTimeout;
        break;
      case DioErrorType.sendTimeout:
        break;
      case DioErrorType.receiveTimeout:
        break;
      case DioErrorType.response:
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.other:
        errorMessage = GeneralLabels.requestErrorDioErrorOther;

        break;
      default:
        break;
    }

    return Text(
      '$errorMessage$messageErrors',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
            backgroundColor: Theme.of(context).colorScheme.background,
            fontWeight: FontWeight.w600,
            height: 1.25,
            color: Colors.black,
          ),
    );
  }
}
