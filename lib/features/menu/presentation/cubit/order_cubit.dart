import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcc_app_front/features/menu/data/models/order.dart';
import 'package:fcc_app_front/features/menu/data/repositories/order_repo.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(const OrderState([]));
  load() async {
    final orders = await OrderRepo.getOrders();
    emit(
      OrderState(orders),
    );
  }

  changeAddress(String address) async {
    List<OrderModel> orders = [
      ...super.state.orders,
    ];
    final order = await OrderRepo.updateOrderAddress(
      address,
      super.state.orders.last.id,
    );
    if (order != null) {
      orders.removeLast();
      orders.add(order);
      emit(
        OrderState(
          orders,
        ),
      );
    }
  }
}
