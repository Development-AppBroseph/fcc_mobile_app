import 'dart:developer';

import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fcc_app_front/features/payment/data/models/payment.dart';
import 'package:fcc_app_front/shared/config/routes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:fcc_app_front/features/payment/data/repositories/payment_repo.dart';

import 'package:fcc_app_front/shared/widgets/snackbar.dart';

class WebCheckoutPage extends StatefulWidget {
  const WebCheckoutPage({
    Key? key,
    required this.url,
    required this.onComplete,
    required this.phone,
  }) : super(key: key);
  final String url;
  final Function onComplete;
  final String phone;
  @override
  State<WebCheckoutPage> createState() => _WebCheckoutPageState();
}

class _WebCheckoutPageState extends State<WebCheckoutPage> {
  late InAppWebViewController _webViewController;
  String? url;
  @override
  void initState() {
    super.initState();
    setState(() {
      url = widget.url;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final bool isLast = await _webViewController.canGoBack();
        if (isLast) {
          _webViewController.goBack();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 70.h, bottom: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  sized40,
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: CustomBackButton(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(
                    widget.url,
                  ),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                  controller.addJavaScriptHandler(
                      handlerName: 'mySum',
                      callback: (List args) {
                        // Here you receive all the arguments from the JavaScript side
                        // that is a List<dynamic>
                        log('From the JavaScript side:');
                        if (kDebugMode) {
                          print(args.lastOrNull);
                        }
                      });
                },
                onLoadStop:
                    (InAppWebViewController controller, Uri? url) async {
                  final PaymentModel? payment =
                      await PaymentRepo.latestPayment();

                  if (payment?.status == 'success' && context.mounted) {
                    widget.onComplete();
                    context.read<AuthCubit>().init();

                    return;
                  } else if (payment?.status == 'timeout' && context.mounted) {
                    ApplicationSnackBar.showErrorSnackBar(
                      context,
                      'Время вашего платежа истекло. Пожалуйста, обновите страницу и попробуйте еще раз',
                      0.9,
                      const EdgeInsets.symmetric(horizontal: 15),
                      3,
                    );
                    context.go(Routes.menu);
                  } else if (payment?.status == 'error' && context.mounted) {
                    ApplicationSnackBar.showErrorSnackBar(
                      context,
                      'Платеж не прошел успешно. Пожалуйста, попробуйте еще раз',
                      0.9,
                      const EdgeInsets.symmetric(horizontal: 15),
                      3,
                    );
                    context.go(Routes.menu);
                  }
                },
                onConsoleMessage: (InAppWebViewController controller,
                    ConsoleMessage consoleMessage) async {
                  log((await controller.getUrl())?.path ?? '');
                  log('console message: ${consoleMessage.message}');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
