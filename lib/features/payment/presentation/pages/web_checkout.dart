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

import 'package:fcc_app_front/shared/constants/colors/color.dart';
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          if (context.canPop()) context.pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 13,
                          color: primaryColorDark,
                        ),
                      ),
                      Text(
                        'Оплата',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).primaryColorDark,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          final PaymentModel? payment =
                              await PaymentRepo.latestPayment();
                          if ((payment == null || payment.status == null) &&
                              context.mounted) {
                            ApplicationSnackBar.showErrorSnackBar(
                              context,
                              'Платеж не прошел успешно. Пожалуйста, попробуйте еще раз',
                              0.9,
                              const EdgeInsets.symmetric(horizontal: 15),
                              3,
                            );
                            return;
                          }
                          if ((payment?.status == 'created' ||
                                  payment?.status == 'confirmed') &&
                              context.mounted) {
                            widget.onComplete();
                            context.read<AuthCubit>().init();
                            context.go(Routes.menu);
                          } else if (payment?.status != 'time out' &&
                              context.mounted) {
                            ApplicationSnackBar.showErrorSnackBar(
                              context,
                              'Время вашего платежа истекло. Пожалуйста, обновите страницу и попробуйте еще раз',
                              0.9,
                              const EdgeInsets.symmetric(horizontal: 15),
                              3,
                            );
                          } else if (payment?.status != 'error' &&
                              context.mounted) {
                            ApplicationSnackBar.showErrorSnackBar(
                              context,
                              'Платеж не прошел успешно. Пожалуйста, попробуйте еще раз',
                              0.9,
                              const EdgeInsets.symmetric(horizontal: 15),
                              3,
                            );
                          } else if (context.mounted) {
                            ApplicationSnackBar.showErrorSnackBar(
                              context,
                              'Вы еще не завершили процесс оплаты',
                              0.9,
                              const EdgeInsets.symmetric(horizontal: 15),
                              3,
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 5.h,
                            horizontal: 10.h,
                          ),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Вперед',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Theme.of(context).primaryColorDark,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 13,
                                color: primaryColorDark,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                    ],
                  )
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
                onLoadStop: (InAppWebViewController controller, Uri? url) {
                  log(url?.path ?? '');
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
