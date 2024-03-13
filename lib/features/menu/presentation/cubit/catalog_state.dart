part of 'catalog_cubit.dart';

class CatalogState extends Equatable {
  final List<CatalogModel> catalogs;

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

  @override
  List<Object> get props => <Object>[
        catalogs,
      ];
}
