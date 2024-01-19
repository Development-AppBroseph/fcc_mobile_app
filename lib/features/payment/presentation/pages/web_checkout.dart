import 'dart:developer';

import 'package:fcc_app_front/export.dart';
import 'package:flutter/foundation.dart';

class WebCheckoutPage extends StatefulWidget {
  const WebCheckoutPage({
    required this.url,
    required this.onComplete,
    required this.phone,
    Key? key,
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
    //TODO: Should use PopScope
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
              padding: EdgeInsets.only(
                top: 70.h,
                bottom: 10.h,
              ),
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
                      IconButton(
                        onPressed: () async {
                          final PaymentModel? payment = await PaymentRepo.latestPayment();
                          if (payment != null) {
                            final String? weburl = await PaymentRepo.getWeblink(
                              payment.membership,
                              payment.amount,
                            );
                            if (weburl != null) {
                              setState(() {
                                url = weburl;
                              });
                              _webViewController.loadUrl(
                                urlRequest: URLRequest(
                                  url: Uri.parse(weburl),
                                ),
                              );
                            }
                          }
                        },
                        icon: const Icon(
                          Icons.replay_outlined,
                          size: 20,
                          color: primaryColorDark,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final PaymentModel? payment = await PaymentRepo.latestPayment();
                          if ((payment == null || payment.status == null) && context.mounted) {
                            ErrorSnackBar.showErrorSnackBar(
                              context,
                              'Платеж не прошел успешно. Пожалуйста, попробуйте еще раз',
                              0.9,
                              const EdgeInsets.symmetric(horizontal: 15),
                              3,
                            );
                            return;
                          }
                          if ((payment?.status != 'success' || payment?.status != 'confirmed') && context.mounted) {
                            widget.onComplete();
                          } else if (payment?.status != 'time out' && context.mounted) {
                            ErrorSnackBar.showErrorSnackBar(
                              context,
                              'Время вашего платежа истекло. Пожалуйста, обновите страницу и попробуйте еще раз',
                              0.9,
                              const EdgeInsets.symmetric(horizontal: 15),
                              3,
                            );
                          } else if (payment?.status != 'error' && context.mounted) {
                            ErrorSnackBar.showErrorSnackBar(
                              context,
                              'Платеж не прошел успешно. Пожалуйста, попробуйте еще раз',
                              0.9,
                              const EdgeInsets.symmetric(horizontal: 15),
                              3,
                            );
                          } else if (context.mounted) {
                            ErrorSnackBar.showErrorSnackBar(
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
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                onConsoleMessage: (
                  InAppWebViewController controller,
                  ConsoleMessage consoleMessage,
                ) async {
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
