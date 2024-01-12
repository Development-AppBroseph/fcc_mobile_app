part of 'catalog_cubit.dart';

class CatalogState extends Equatable {
  const CatalogState(
    this.catalogs,
  );
  final List<CatalogModel> catalogs;
  @override
  List<Object> get props => [catalogs];
}
