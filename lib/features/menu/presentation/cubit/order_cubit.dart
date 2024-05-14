import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/menu/data/datasources/order_repo.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(const OrderState(<OrderModel>[]));
  dynamic load() async {
    final List<OrderModel> orders = await OrderRepo.getOrders();
    emit(
      state.copyWith(orders: orders),
    );
  }

  Future<Product?> getProductbyId({required String productUuid}) async {
    final Product? product = await OrderRepository.getProductbyId(
      productUuid: productUuid,
    );
    return product;
  }

  dynamic changeAddress(String address) async {
    List<OrderModel> orders = <OrderModel>[
      ...super.state.orders,
    ];
    final OrderModel? order = await OrderRepo.updateOrderAddress(
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
