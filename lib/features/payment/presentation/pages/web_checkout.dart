import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';

class WebCheckoutPage extends StatefulWidget {
  const WebCheckoutPage({
    required this.url,
    required this.phone,
    Key? key,
  }) : super(key: key);

  final String url;
  final String phone;

  @override
  State<WebCheckoutPage> createState() => _WebCheckoutPageState();
}

class _WebCheckoutPageState extends State<WebCheckoutPage> {
  late InAppWebViewController _webViewController;

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
              padding: const EdgeInsets.only(
                top: 70,
                bottom: 10,
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      if (Navigator.of(context).canPop()) {
                        context.read<AuthCubit>().init();
                        Navigator.of(context).pop();
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 13,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    'Оплата',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.blue,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(widget.url),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                  controller.addJavaScriptHandler(
                    handlerName: 'flutter_bridge',
                    callback: (List<dynamic> data) {
                      log('Received payment data: $data');
                      handlePaymentData(
                          jsonDecode(data.first ?? '') as Map<String, dynamic>);
                    },
                  );
                },
                onLoadStop:
                    (InAppWebViewController controller, Uri? url) async {
                  log(url?.path ?? '');
                  controller.evaluateJavascript(
                      source:
                          'window.flutter_bridge.postMessage("requestPaymentData");');
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

  void handlePaymentData(Map<String, dynamic> data) {
    if (data['status'] == 'success') {
      print('Success payment data: $data');
    } else {
      print('Неуспешный платеж: $data');
    }
  }
}
