import 'dart:async';

import 'package:fcc_app_front/export.dart';

class WebCheckoutPage extends StatefulWidget {
  const WebCheckoutPage({
    super.key,
    required this.url,
    required this.onComplete,
    required this.phone,
  });
  final String url;
  final Function onComplete;
  final String phone;
  @override
  State<WebCheckoutPage> createState() => _WebCheckoutPageState();
}

class _WebCheckoutPageState extends State<WebCheckoutPage> {
  late InAppWebViewController _webViewController;
  String? url;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    setState(() {
      url = widget.url;
    });
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      _checkLatestPayment();
    });
  }

  String extra(int membership) {
    if (membership == 1) {
      return 'Стандарт';

    } else if (membership == 2) {
      return 'Премиум';
    } else if (membership == 3) {
      return 'Элит';
    } else {
      return '4';
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AuthCubit>().init();
        context.go(
          Routes.menu,
        );
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
                  url: WebUri(
                    widget.url,
                  ),
                ),
                onWebViewCreated: (InAppWebViewController controller) {
                  _webViewController = controller;
                },
                onLoadStop:
                    (InAppWebViewController controller, Uri? url) async {},
                onConsoleMessage: (InAppWebViewController controller,
                    ConsoleMessage consoleMessage) async {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _checkLatestPayment() async {
    final PaymentModel? payment = await PaymentRepo.latestPayment();

    if (payment?.status == 'success' && context.mounted) {
      context.read<AuthCubit>().init();
      context.go(
        Routes.paymentCongrats,
        extra: <String, dynamic>{
          'membership': extra(payment!.membership),
          'goMenu': true,
        },
      );
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
  }
}
