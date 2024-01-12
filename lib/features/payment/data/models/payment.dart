class PaymentModel {
  final int id;
  final int client;
  final int membership;
  final String amount;
  final String? paymentId;
  final String? status;
  final String? error;
  PaymentModel({
    required this.id,
    required this.client,
    required this.membership,
    required this.amount,
    this.paymentId,
    this.status,
    this.error,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'client': client,
      'membership': membership,
      'amount': amount,
      'paymentId': paymentId,
      'status': status,
      'error': error,
    };
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      id: map['id'] as int,
      client: map['client'] as int,
      membership: map['membership'] as int,
      amount: map['amount'] as String,
      paymentId: map['paymentId'] as String?,
      status: map['status'] != null ? map['status'] as String : null,
      error: map['error'] != null ? map['error'] as String : null,
    );
  }
}
