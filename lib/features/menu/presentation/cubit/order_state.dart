part of 'order_cubit.dart';

class OrderState extends Equatable {
  const OrderState(
    this.orders,
  );
  final List<OrderModel> orders;
  @override
  List<Object> get props => [orders];
}
