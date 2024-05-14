part of 'selected_products_cubit.dart';

class SelectedProductsState extends Equatable {
  const SelectedProductsState({this.product});
  final Product? product;
  @override
  List<Object?> get props => <Object?>[
        product,
      ];
}
