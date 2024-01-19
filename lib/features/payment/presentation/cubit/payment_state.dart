part of 'payment_cubit.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => <Object>[];
}

class PaymentInitial extends PaymentState {}
