import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcc_app_front/features/auth/data/models/membership.dart';
import 'package:fcc_app_front/features/auth/data/repositories/auth_repo.dart';
import 'package:fcc_app_front/features/menu/data/models/catalog.dart';
import 'package:fcc_app_front/features/menu/data/repositories/catalog_repo.dart';

part 'catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit() : super(const CatalogState(<CatalogModel>[]));

  CatalogModel getById(String id) {
    return super.state.catalogs.firstWhere(
      (CatalogModel element) {
        return element.id.toString() == id;
      },
    );
  }

  Future<void> getAllCatalogsById(
    String membershipId,
  ) async {
    final List<CatalogModel> catalogs = await CatalogRepo.getCatalogs(
      catalogId: membershipId,
    );

    emit(CatalogState(catalogs));
  }
}
