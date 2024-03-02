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

  Future<ProductModel?> getProductbyId({required String productUuid}) async {
    final ProductModel? product = await OrderRepository.getProductbyId(
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

//   Future<bool> makeOrder({
//     required String productId,
//     required ProductModel product,
//     required int address,
//     required String name,
//     required String phone,
//     required String email,
//   }) async {
//     try {
//       await OrderRepo.placeOrder(
//         address: address,
//         name: name,
//         phone: phone,
//         email: email,
//       );
//       return true;
//     } catch (exception) {
//       if (exception is OrderException &&
//           exception.message.contains('limit reached')) {
//         print(exception.message);
//         return false;
//       }
//     }
//     return false;
//   }
// }
}
