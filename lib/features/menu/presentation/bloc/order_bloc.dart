import 'dart:async';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/menu/data/datasources/order_repo.dart';
import 'package:fcc_app_front/features/menu/data/models/address.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, AddressOrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<FetchAllAddreses>(_fetchAllAddreses);
  }

  Future<void> _fetchAllAddreses(
    FetchAllAddreses event,
    Emitter<AddressOrderState> emit,
  ) async {
    try {
      emit(OrderLoading());

      final List<Address> addreses =
          await OrderRepository().searchAddressByName(event.address);
      emit(OrderSuccess(addresses: addreses));
    } catch (e) {
      emit(OrderError(message: e.toString()));
    }
  }
}
