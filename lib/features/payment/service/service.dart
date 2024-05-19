import 'dart:async';

import 'package:fcc_app_front/features/payment/data/repositories/payment_repo.dart';

class PaymentService {
  static final PaymentService _instance = PaymentService._internal();
  factory PaymentService() => _instance;

  PaymentService._internal();

  final StreamController<String> _paymentStatusController =
      StreamController<String>.broadcast();
  Stream<String> get paymentStatusStream => _paymentStatusController.stream;

  Timer? _timer;

  void startCheckingPaymentStatus() {
    stopCheckingPaymentStatus(); // Останавливаем предыдущий таймер, если он был запущен

    _timer = Timer.periodic(const Duration(seconds: 20), (_) async {
      final payment = await PaymentRepo.latestPayment();
      if (payment != null && payment.status != null) {
        _paymentStatusController.add(payment.status!);
        if (payment.status == 'success' ||
            payment.status == 'timeout' ||
            payment.status == 'error') {
          stopCheckingPaymentStatus(); // Останавливаем проверку при любом финальном статусе
        }
      }
    });
  }

  void stopCheckingPaymentStatus() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    _paymentStatusController.close();
    stopCheckingPaymentStatus();
  }
}
