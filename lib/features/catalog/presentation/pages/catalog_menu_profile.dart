import 'package:auto_animated/auto_animated.dart';
import 'package:fcc_app_front/features/catalog/data/datasources/catalog.dart';
import 'package:fcc_app_front/features/menu/data/models/multiple_cubits.dart';
import 'package:fcc_app_front/features/menu/data/utils/search.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/catalog_cubit.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/product_cubit.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/search.dart';
import 'package:fcc_app_front/shared/config/routes.dart';
import 'package:fcc_app_front/shared/constants/widgets/custom_back.dart';
import 'package:fcc_app_front/shared/constants/widgets/sizedbox.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../menu/data/utils/get_by_membership.dart';
import '../../../menu/presentation/widgets/catalog_cart.dart';

class CatalogMenuProfile extends StatefulWidget {
  const CatalogMenuProfile({
    Key? key,
    required this.type,
  }) : super(key: key);
  final MembershipType type;

  @override
  State<CatalogMenuProfile> createState() => _CatalogMenuProfileState();
}

class _CatalogMenuProfileState extends State<CatalogMenuProfile> {
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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
        BlocProvider(
          create: (context) => ProductCubit()..loadPublic(),
        ),
        BlocProvider(
          create: (context) => CatalogCubit()..loadPublic(),
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
                        Text(
                          membershipNames[widget.type]?.toUpperCase() ??
                              membershipNames.values.first.toUpperCase(),
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: 26,
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                        sized20,
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
                      return BlocBuilder<CatalogCubit, CatalogState>(
                        builder: (context, state) {
                          final catalogs = searchCatalog(
                            query,
                            getCatalogByMembership(
                              state.catalogs,
                              widget.type,
                            ),
                          );
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
                                  child: CatalogCart(
                                    catalog: catalogs[index],
                                    function: () {
                                      context.pushNamed(
                                        RoutesNames.catalogProductProfile,
                                        extra: MultipleCubits(
                                          cubits: {
                                            'productCubit':
                                                BlocProvider.of<ProductCubit>(
                                                    context),
                                            'catalogCubit':
                                                BlocProvider.of<CatalogCubit>(
                                                    context),
                                          },
                                        ),
                                        pathParameters: {
                                          'id': catalogs[index].id.toString(),
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                              itemCount: catalogs.length,
                            ),
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
