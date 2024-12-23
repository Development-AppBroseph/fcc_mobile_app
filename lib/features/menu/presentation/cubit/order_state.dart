part of 'order_cubit.dart';

class OrderState extends Equatable {
  final List<OrderModel> orders;

  const OrderState(
    this.orders,
  );
  @override
  List<Object> get props => <Object>[
        orders,
      ];

  OrderState copyWith({
    List<OrderModel>? orders,
  }) {
    return OrderState(
      orders ?? this.orders,
    );
  }
}
