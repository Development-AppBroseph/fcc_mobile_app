import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/product.dart';
import '../../data/repositories/product_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState([]));
  load({bool isPublic = false}) async {
    final products = await ProductRepo.getProducts(isPublic: isPublic);
    emit(
      ProductState(
        products,
      ),
    );
  }

  loadPublic() async {
    final products = await ProductRepo.getProducts(isPublic: true);
    emit(
      ProductState(
        products,
      ),
    );
  }

  ProductModel getById(String id) {
    return super.state.products.firstWhere(
          (element) => element.id.toString() == id,
        );
  }
}
