import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fcc_app_front/features/menu/data/models/catalog.dart';
import 'package:fcc_app_front/features/menu/data/repositories/catalog_repo.dart';

part 'catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit() : super(const CatalogState(<CatalogModel>[]));
  void load({
    bool isPublic = false,
  }) async {
    // final List<CatalogModel> catalogs = await CatalogRepo.getCatalogs(
    //   isPublic: isPublic,
    // );
    // emit(state.copyWith(catalogs: catalogs));
  }

  void loadPublic() async {
    // final List<CatalogModel> catalogs = await CatalogRepo.getCatalogs(
    //   isPublic: true,
    // );
    // emit(
    //   CatalogState(
    //     catalogs,
    //   ),
    // );
  }

  CatalogModel getById(String id) {
    return super.state.catalogs.firstWhere(
      (CatalogModel element) {
        return element.id.toString() == id;
      },
    );
  }

  Future<void> getUnAuthenticatedCatalogsByMembershipId(
    String membershipId,
  ) async {
    final List<CatalogModel> catalogs = await CatalogRepo.getCatalogs(
      catalogId: membershipId,
    );

    emit(state.copyWith(catalogs: catalogs));
  }
}
