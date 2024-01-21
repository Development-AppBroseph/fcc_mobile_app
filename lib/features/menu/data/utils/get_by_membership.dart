import 'package:fcc_app_front/features/catalog/data/datasources/catalog.dart';
import 'package:fcc_app_front/features/menu/data/models/catalog.dart';

List<CatalogModel> getCatalogByMembership(
  List<CatalogModel> allCatalogs,
  MembershipType? type,
) {
  if (type == null) return allCatalogs;
  switch (type) {
    case MembershipType.standard:
      return allCatalogs
          .where(
            (CatalogModel element) => element.membership == MembershipType.standard.name,
          )
          .toList();
    case MembershipType.premium:
      List<CatalogModel> catalogs = <CatalogModel>[];
      catalogs.addAll(
        allCatalogs.where(
          (CatalogModel element) => element.membership == MembershipType.standard.name,
        ),
      );
      catalogs.addAll(
        allCatalogs.where(
          (CatalogModel element) => element.membership == MembershipType.premium.name,
        ),
      );
      return catalogs;
    case MembershipType.elite:
      return allCatalogs;
  }
}
