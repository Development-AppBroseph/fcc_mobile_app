import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcc_app_front/features/menu/data/models/product.dart';
import 'package:fcc_app_front/features/menu/data/repositories/product_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(const ProductState(<ProductModel>[]));
  load({bool isPublic = false}) async {
    // final List<ProductModel> products = await ProductRepo.getProducts(isPublic: isPublic);
    // emit(
    //   ProductState(
    //     products,
    //   ),
    // );
  }

  loadPublic() async {
    // final List<ProductModel> products = await ProductRepo.getProducts(isPublic: true);
    // emit(
    //   ProductState(
    //     products,
    //   ),
    // );
  }

  ProductModel getById(String id) {
    return super.state.products.firstWhere(
          (ProductModel element) => element.id.toString() == id,
        );
  }

  Future<void> getAuthenticatedProductByCatalogId(String catalogId) async {
    final List<ProductModel> products = await ProductRepo.getProducts(
      catalodId: catalogId,
    );
    emit(
      ProductState(
        products,
      ),
    );
  }
}
