part of 'catalog_cubit.dart';

class CatalogState extends Equatable {
  const CatalogState(
    this.catalogs,
  );

  CatalogState copyWith({
    List<CatalogModel>? catalogs,
  }) {
    return CatalogState(
      catalogs ?? this.catalogs,
    );
  }

  final List<CatalogModel> catalogs;
  @override
  List<Object> get props => <Object>[
        catalogs,
      ];
}
