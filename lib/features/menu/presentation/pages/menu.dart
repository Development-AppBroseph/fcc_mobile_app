import 'package:fcc_app_front/export.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
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
      create: (BuildContext context) => SearchCubit(),
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                left: 30.w,
                right: 30.w,
                top: 20.h,
              ),
              child: BlocBuilder<SelectedMembershipCubit, MembershipType?>(
                builder: (BuildContext context, MembershipType? selectedMembership) {
                  return CustomScrollView(
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            selectedMembership != null && context.watch<AuthCubit>().state is Unauthenticated
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CustomBackButton(
                                        path: RoutesNames.introCatalog,
                                      ),
                                      sized10,
                                      Text(
                                        membershipNames[MembershipType.values.any((MembershipType element) {
                                              return element == selectedMembership;
                                            })
                                                    ? MembershipType.values.firstWhereOrNull((MembershipType element) {
                                                        return element == selectedMembership;
                                                      })
                                                    : null]
                                                ?.toUpperCase() ??
                                            membershipNames.values.first.toUpperCase(),
                                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                                  hintText: 'Поиск',
                                  hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                      BlocListener<AuthCubit, AuthState>(
                        listener: (BuildContext context, AuthState state) {
                          context.read<CatalogCubit>().load(
                                isPublic: context.read<AuthCubit>().state is Unauthenticated,
                              );
                        },
                        child: BlocProvider(
                          create: (BuildContext context) => SearchCubit(),
                          child: BlocBuilder<SearchCubit, String?>(
                            builder: (BuildContext context, String? query) {
                              return BlocBuilder<CatalogCubit, CatalogState>(
                                builder: (BuildContext context, CatalogState state) {
                                  final AuthState authState = context.watch<AuthCubit>().state;
                                  final List<CatalogModel> catalogs = searchCatalog(
                                    query,
                                    getCatalogByMembership(
                                      state.catalogs,
                                      selectedMembership != null &&
                                              MembershipType.values
                                                  .any((MembershipType element) => element == selectedMembership) &&
                                              authState is Unauthenticated
                                          ? MembershipType.values.firstWhereOrNull(
                                              (MembershipType element) => element == selectedMembership)
                                          : authState is Authenticated &&
                                                  MembershipType.values.any((MembershipType element) {
                                                    return element.name == authState.user.membership;
                                                  })
                                              ? MembershipType.values.firstWhereOrNull(
                                                  (MembershipType element) => element.name == authState.user.membership,
                                                )
                                              : null,
                                    ),
                                  );
                                  if (authState is Authenticated && authState.user.membership == 'no membership') {
                                    return SliverToBoxAdapter(
                                      child: SizedBox(
                                        height: 400.h,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Пожалуйста выберите план для подписки',
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
                                            child: CatalogCart(
                                              catalog: catalogs[index],
                                              function: () {
                                                context.pushNamed(
                                                  RoutesNames.productMenu,
                                                  pathParameters: <String, String>{
                                                    'id': catalogs[index].id.toString(),
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: catalogs.length,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
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
