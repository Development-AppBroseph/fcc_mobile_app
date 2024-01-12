import 'package:auto_animated/auto_animated.dart';
import 'package:collection/collection.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/selected_membership_cubit.dart';
import 'package:fcc_app_front/shared/constants/widgets/custom_back.dart';
import 'package:fcc_app_front/shared/widgets/buttons/cstm_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:fcc_app_front/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fcc_app_front/features/catalog/data/datasources/catalog.dart';
import 'package:fcc_app_front/features/menu/data/utils/get_by_membership.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/catalog_cubit.dart';
import 'package:fcc_app_front/features/menu/presentation/widgets/catalog_cart.dart';

import '../../../../shared/config/routes.dart';
import '../../../../shared/constants/widgets/sizedbox.dart';
import '../../data/utils/search.dart';
import '../cubit/search.dart';
import '../widgets/user_info.dart';

class Menu extends StatefulWidget {
  const Menu({
    Key? key,
  }) : super(key: key);
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (context.read<CatalogCubit>().state.catalogs.isEmpty) {
        context.read<CatalogCubit>().load(
              isPublic: context.read<AuthCubit>().state is Unauthenticated,
            );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
                top: 20.h,
              ),
              child: BlocBuilder<SelectedMembershipCubit, MembershipType?>(
                builder: (context, selectedMembership) {
                  return CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            selectedMembership != null &&
                                    context.watch<AuthCubit>().state is Unauthenticated
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomBackButton(
                                        path: RoutesNames.introCatalog,
                                      ),
                                      sized10,
                                      Text(
                                        membershipNames[MembershipType.values.any(
                                                        (element) =>
                                                            element == selectedMembership)
                                                    ? MembershipType.values
                                                        .firstWhereOrNull((element) =>
                                                            element == selectedMembership)
                                                    : null]
                                                ?.toUpperCase() ??
                                            membershipNames.values.first.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontSize: 26,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ],
                                  )
                                : const MenuUserInfo(),
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
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                    ),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(0),
                                  hintText: "Поиск",
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
                                onChanged: (value) {
                                  context.read<SearchCubit>().search(value);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) {
                          context.read<CatalogCubit>().load(
                                isPublic:
                                    context.read<AuthCubit>().state is Unauthenticated,
                              );
                        },
                        child: BlocBuilder<SearchCubit, String?>(
                          builder: (context, query) {
                            return BlocBuilder<CatalogCubit, CatalogState>(
                              builder: (context, state) {
                                final authState = context.watch<AuthCubit>().state;
                                final catalogs = searchCatalog(
                                  query,
                                  getCatalogByMembership(
                                    state.catalogs,
                                    selectedMembership != null &&
                                            MembershipType.values.any((element) =>
                                                element == selectedMembership) &&
                                            authState is Unauthenticated
                                        ? MembershipType.values.firstWhereOrNull(
                                            (element) => element == selectedMembership)
                                        : authState is Authenticated &&
                                                MembershipType.values.any((element) =>
                                                    element.name ==
                                                    authState.user.membership)
                                            ? MembershipType.values.firstWhereOrNull(
                                                (element) =>
                                                    element.name ==
                                                    authState.user.membership,
                                              )
                                            : null,
                                  ),
                                );
                                if (authState is Authenticated &&
                                    authState.user.membership == "no membership") {
                                  return SliverToBoxAdapter(
                                    child: SizedBox(
                                      height: 400.h,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Пожалуйста выберите план для подписки",
                                            style: Theme.of(context).textTheme.bodyMedium,
                                            textAlign: TextAlign.center,
                                          ),
                                          sized30,
                                          CstmBtn(
                                              text: 'Выбрать план',
                                              onTap: () {
                                                context.goNamed(
                                                  RoutesNames.settings,
                                                );
                                                context.pushNamed(
                                                  RoutesNames.changePlan,
                                                  extra: authState.user.phoneNumber,
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                                return SliverPadding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 20.h,
                                  ),
                                  sliver: LiveSliverList(
                                    controller: _scrollController,
                                    showItemInterval: const Duration(milliseconds: 150),
                                    showItemDuration: const Duration(milliseconds: 200),
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
                                              RoutesNames.productMenu,
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
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
