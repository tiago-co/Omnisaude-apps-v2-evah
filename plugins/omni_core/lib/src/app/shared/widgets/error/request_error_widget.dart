import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:omni_core/omni_core.dart';
import 'package:omni_general/omni_general.dart';
import 'package:shared_labels/labels.dart';

class RequestErrorErrorWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final DioError? error;
  final String message;

  const RequestErrorErrorWidget({
    Key? key,
    this.buttonText = SharedLabels.requestErrorTryAgain,
    this.onPressed,
    this.message = SharedLabels.requestErrorMessage,
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
            SharedLabels.requestErrorSomethingWrong,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Opacity(
                  opacity: 0.5,
                  child: Lottie.asset(
                    Assets.errorLottie,
                    package: AssetsPackage.omniCore,
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: _messageErrorWidget(context),
                  ),
                ),
              ],
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
    String message0 = message;
    String messageErrors0 = '';
    switch (error?.response?.statusCode) {
      case 400:
        final Map<String, dynamic>? errors = error!.response!.data['errors'];
        errors?.forEach((key, value) {
          if (value == null) return;
          messageErrors0 += '* $key: $value\n';
        });
        message0 = SharedLabels.requestError400;
        break;
      case 401:
        message0 = SharedLabels.requestError401;
        break;
      case 403:
        final Map<String, dynamic>? errors = error!.response!.data['errors'];
        errors?.forEach(
          (key, value) {
            if (value == null) return;
            if (value == 'Unauthorized user') {
              message0 = SharedLabels.requestErrorUnauthorizedUser;
            } else if (key == '') {
              message0 = value;
            } else {
              message0 = SharedLabels.requestError403;
            }
          },
        );
        break;
      case 404:
        message0 = SharedLabels.requestError404;
        break;
      case 405:
        message0 = SharedLabels.requestError405;
        break;
      case 500:
        message0 = SharedLabels.requestError500;
        break;
      case 502:
        message0 = SharedLabels.requestError502;
        break;
      case 503:
        message0 = SharedLabels.requestError503;
        break;
      default:
        break;
    }

    switch (error?.type) {
      case DioErrorType.connectTimeout:
        message0 = SharedLabels.requestErrorDioErrorConnectTimeout;
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
        message0 = SharedLabels.requestErrorDioErrorOther;
        break;
      default:
        break;
    }

    return Text(
      '$message0$messageErrors0',
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
