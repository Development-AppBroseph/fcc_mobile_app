import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcc_app_front/features/menu/data/models/product.dart';

part 'selected_products_state.dart';

class SelectedProductsCubit extends Cubit<SelectedProductsState> {
  SelectedProductsCubit()
      : super(
          const SelectedProductsState(),
        );
  dynamic addProduct(ProductModel? product) {
    if (product == null) {
      emit(
        const SelectedProductsState(),
      );
    } else if (super.state.product != null && super.state.product!.id == product.id) {
      emit(
        const SelectedProductsState(),
      );
    } else {
      emit(
        SelectedProductsState(
          product: product,
        ),
      );
    }
  }
}
