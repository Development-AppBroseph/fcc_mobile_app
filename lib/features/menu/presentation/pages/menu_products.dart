import 'package:fcc_app_front/export.dart';

class ProductMenu extends StatefulWidget {
  final String catalogId;
  const ProductMenu({
    Key? key,
    required this.catalogId,
  }) : super(key: key);

  @override
  State<ProductMenu> createState() => _ProductMenuState();
}

class _ProductMenuState extends State<ProductMenu> {
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final CatalogModel catalog =
        context.watch<CatalogCubit>().getById(widget.catalogId);
    return Builder(builder: (BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 30.w,
              right: 30.w,
              top: 20.h,
            ),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const CustomBackButton(),
                      sized20,
                      Text(
                        catalog.name.toUpperCase(),
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                        maxLines: 1,
                        //minFontSize: 16,
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
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                  ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.all(0),
                            hintText: 'Поиск',
                            hintStyle:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
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
                            context.watch<SearchCubit>().search(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<SearchCubit, String?>(
                  builder: (BuildContext context, String? query) {
                    return BlocBuilder<ProductCubit, ProductState>(
                      builder: (BuildContext context, ProductState state) {
                        final List<ProductModel> products = searchProduct(
                          query,
                          state.products
                              .where(
                                (ProductModel element) =>
                                    element.catalog.toString() ==
                                    widget.catalogId,
                              )
                              .toList(),
                        );
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
                                itemBuilder: (
                                  BuildContext context,
                                  int index,
                                  Animation<double> animation,
                                ) {
                                  return FadeTransition(
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
                                      child: ProductCart(
                                        product: products[index],
                                        isSelected:
                                            selectedProducts.product != null &&
                                                selectedProducts.product!.id ==
                                                    products[index].id,
                                      ),
                                    ),
                                  );
                                },
                                itemCount: products.length,
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
