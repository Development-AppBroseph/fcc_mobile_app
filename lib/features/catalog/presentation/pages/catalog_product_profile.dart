import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/catalog/presentation/widget/catalog_card.dart';

class CatalogProductProfileMenu extends StatefulWidget {
  final String? catalogId;
  const CatalogProductProfileMenu({
    super.key,
    required this.catalogId,
  });

  @override
  State<CatalogProductProfileMenu> createState() =>
      _CatalogProductProfileMenuState();
}

class _CatalogProductProfileMenuState extends State<CatalogProductProfileMenu> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    context
        .read<ProductCubit>()
        .getAuthenticatedProductByCatalogId(widget.catalogId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final CatalogModel catalog =
        context.read<CatalogCubit>().getById(widget.catalogId ?? '');
    return Builder(builder: (BuildContext context) {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double availableWidth = constraints.maxWidth;

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: availableWidth < 600
                    ? const EdgeInsets.only(
                        left: 30,
                        right: 30,
                      )
                    : EdgeInsets.only(
                        left: 30 + (availableWidth - 600) / 2,
                        right: 30 + (availableWidth - 600) / 2,
                      ),
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const CustomBackButton(),
                          sized20,
                          AutoSizeText(
                            catalog.name.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w700,
                                ),
                            maxLines: 1,
                            minFontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          ),
                          sized10,
                          Container(
                            height: 42,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[100]!.withOpacity(0.7),
                            ),
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  ),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.all(0),
                                hintText: 'Поиск',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                prefixIcon: Icon(
                                  CupertinoIcons.search,
                                  size: 13,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                              onChanged: (String value) {
                                context.read<SearchCubit>().search(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<SearchCubit, String?>(
                      builder: (BuildContext context, String? query) {
                        return BlocBuilder<ProductCubit, ProductState>(
                          builder: (
                            BuildContext context,
                            ProductState state,
                          ) {
                            final List<Product> products = searchProduct(
                              query,
                              state.products
                                  .where(
                                    (Product element) =>
                                        element.catalog.toString() ==
                                        widget.catalogId,
                                  )
                                  .toList(),
                            );

                            if (state.products.isNotEmpty) {
                              return BlocBuilder<SelectedProductsCubit,
                                  SelectedProductsState>(
                                builder: (BuildContext context,
                                    SelectedProductsState selectedProducts) {
                                  return SliverPadding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 20.h,
                                    ),
                                    sliver: LiveSliverList(
                                      controller: _scrollController,
                                      showItemInterval:
                                          const Duration(milliseconds: 150),
                                      showItemDuration:
                                          const Duration(milliseconds: 200),
                                      itemBuilder: (BuildContext context,
                                              int index,
                                              Animation<double> animation) =>
                                          FadeTransition(
                                        opacity: Tween<double>(
                                          begin: 0,
                                          end: 1,
                                        ).animate(animation),
                                        // And slide transition
                                        child: SlideTransition(
                                          position: Tween<Offset>(
                                            begin: const Offset(0, -0.1),
                                            end: Offset.zero,
                                          ).animate(animation),
                                          child: CatalogCard(
                                            product: products[index],
                                            isSelected: selectedProducts
                                                        .product !=
                                                    null &&
                                                selectedProducts.product!.id ==
                                                    products[index].id,
                                          ),
                                        ),
                                      ),
                                      itemCount: products.length,
                                    ),
                                  );
                                },
                              );
                            } else {
                              return SliverFillRemaining(
                                hasScrollBody: false,
                                child: FutureBuilder<dynamic>(
                                  future: Future<dynamic>.delayed(
                                    const Duration(milliseconds: 300),
                                  ),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return const Center(
                                        child: Text(
                                          'Данный товар временно недоступен',
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
