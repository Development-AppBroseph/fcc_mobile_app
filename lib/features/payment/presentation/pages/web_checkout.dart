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
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w400,
                        ),
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
