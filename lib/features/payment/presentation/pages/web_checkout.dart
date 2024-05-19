import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/payment/service/service.dart';
import 'package:fcc_app_front/shared/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';

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

  @override
  void initState() {
    super.initState();
    Provider.of<PaymentService>(context, listen: false)
        .startCheckingPaymentStatus();
    Provider.of<PaymentService>(context, listen: false)
        .paymentStatusStream
        .listen((status) {
      _handlePaymentStatus(status);
    });
  }

  @override
  void dispose() {
    // Не останавливаем проверку при выходе с экрана, чтобы запросы продолжались
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<AuthCubit>().init();
        context.go(Routes.menu);
        return true;
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 70.h, bottom: 10.h),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 40),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: CustomBackButton(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                  url: WebUri(widget.url),
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

  void _handlePaymentStatus(String status) {
    if (context.mounted) {
      if (status == 'success') {
        Provider.of<PaymentService>(context, listen: false)
            .stopCheckingPaymentStatus(); // Останавливаем проверку при успешной оплате
        context.read<AuthCubit>().init();
        context.go(
          Routes.paymentCongrats,
          extra: <String, dynamic>{
            'membership': extra(1), // replace with actual membership level
            'goMenu': true,
          },
        );
      } else if (status == 'timeout') {
        Provider.of<PaymentService>(context, listen: false)
            .stopCheckingPaymentStatus(); // Останавливаем проверку при тайм-ауте
        ApplicationSnackBar.showErrorSnackBar(
          context,
          'Время вашего платежа истекло. Пожалуйста, обновите страницу и попробуйте еще раз',
          0.9,
          const EdgeInsets.symmetric(horizontal: 15),
          3,
        );
        context.go(Routes.menu);
      } else if (status == 'error') {
        Provider.of<PaymentService>(context, listen: false)
            .stopCheckingPaymentStatus(); // Останавливаем проверку при ошибке
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

  String extra(int membership) {
    switch (membership) {
      case 1:
        return 'Стандарт';
      case 2:
        return 'Премиум';
      case 3:
        return 'Элит';
      default:
        return '4';
    }
  }
}
