import 'package:auto_animated/auto_animated.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:fcc_app_front/features/menu/data/utils/search_product.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/catalog_cubit.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/selected_products_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/constants/widgets/custom_back.dart';
import '../../../../shared/constants/widgets/sizedbox.dart';
import '../../../menu/presentation/cubit/product_cubit.dart';
import '../../../menu/presentation/cubit/search.dart';
import '../../../menu/presentation/widgets/cart.dart';

class CatalogProductProfileMenu extends StatefulWidget {
  final String catalogId;
  const CatalogProductProfileMenu({
    Key? key,
    required this.catalogId,
  }) : super(key: key);

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
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final catalog = context.read<CatalogCubit>().getById(widget.catalogId);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => SelectedProductsCubit(),
        ),
      ],
      child: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
                top: 20.h,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomBackButton(),
                        sized20,
                        AutoSizeText(
                          catalog.name.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.all(0),
                              hintText: "Поиск",
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
                            onChanged: (value) {
                              context.read<SearchCubit>().search(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<SearchCubit, String?>(
                    builder: (context, query) {
                      return BlocBuilder<ProductCubit, ProductState>(
                        builder: (context, state) {
                          final products = searchProduct(
                            query,
                            state.products
                                .where(
                                  (element) =>
                                      element.catalog.toString() ==
                                      widget.catalogId,
                                )
                                .toList(),
                          );
                          return BlocBuilder<SelectedProductsCubit,
                              SelectedProductsState>(
                            builder: (context, selectedProducts) {
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
                                  itemBuilder: (context, index, animation) =>
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
                                      child: ProductCart(
                                        product: products[index],
                                        isSelected:
                                            selectedProducts.product != null &&
                                                selectedProducts.product!.id ==
                                                    products[index].id,
                                        canSelect: false,
                                      ),
                                    ),
                                  ),
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
      }),
    );
  }
}
