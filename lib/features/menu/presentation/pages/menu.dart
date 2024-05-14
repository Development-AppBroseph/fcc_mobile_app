import 'dart:convert';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Menu extends StatefulWidget {
  final String? catalogId;

  const Menu({
    super.key,
    required this.catalogId,
  });
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late ScrollController _scrollController;

  late WebSocketChannel _channel;

  @override
  void initState() {
    final int? userId = getClientId();
    _channel = WebSocketChannel.connect(
        Uri.parse('$socketUrl$userId?token=${getToken()}'));
    _channel.stream.listen((dynamic event) {
      MessageModel parsed = MessageModel.fromJson(jsonDecode(event));
      ValueNotifier<bool> isAdmin =
          ValueNotifier<bool>(parsed.message.clientSend);

      log(parsed.toJson().toString());

      if (!isAdmin.value) {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(
                  16,
                ),
                backgroundColor: Colors.white,
                elevation: 0,
                icon: const Icon(Icons.message),
                actions: <Widget>[
                  CstmBtn(
                    key: UniqueKey(),
                    text: 'Закрыть',
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
                title: Column(
                  children: <Widget>[
                    Text(
                      'ФКК',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Новое сообщение в чате',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                content: Card(
                  elevation: 0,
                  color: Colors.white,
                  child: Text(parsed.message.message ?? ''),
                ),
              );
            });
      }
    });
    _scrollController = ScrollController();
    context.read<AuthCubit>().init();
    super.initState();
    getMemberSheep();
  }

  Future<void> getMemberSheep() async {
    final AuthState state = context.read<AuthCubit>().state;

    if (state is Authenticated) {
      context.read<CatalogCubit>().getAllCatalogsById(
          state.user.userMembership?.membership?.id.toString() ??
              widget.catalogId ??
              '');
    }
  }

  @override
  Widget build(BuildContext context) {
    getMemberSheep();
    return BlocProvider<SearchCubit>(
      create: (BuildContext context) => SearchCubit(),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double boxWidth = constraints.maxWidth;

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: boxWidth < 600
                    ? const EdgeInsets.only(
                        left: 30,
                        right: 30,
                      )
                    : EdgeInsets.only(
                        left: 30 + (boxWidth - 600) / 2,
                        right: 30 + (boxWidth - 600) / 2,
                      ),
                child: BlocBuilder<SelectedMembershipCubit, MembershipType?>(
                  builder: (BuildContext context,
                      MembershipType? selectedMembership) {
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              selectedMembership != null &&
                                      context.watch<AuthCubit>().state
                                          is Unauthenticated
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        CustomBackButton(
                                          path: RoutesNames.introCatalog,
                                        ),
                                        sized10,
                                        Text(
                                          membershipNames[MembershipType.values
                                                          .any((MembershipType
                                                              element) {
                                                return element ==
                                                    selectedMembership;
                                              })
                                                      ? MembershipType.values
                                                          .firstWhereOrNull(
                                                              (MembershipType
                                                                  element) {
                                                          return element ==
                                                              selectedMembership;
                                                        })
                                                      : null]
                                                  ?.toUpperCase() ??
                                              membershipNames.values.first
                                                  .toUpperCase(),
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
                            return BlocBuilder<CatalogCubit, CatalogState>(
                              builder:
                                  (BuildContext context, CatalogState state) {
                                final AuthState authState =
                                    context.watch<AuthCubit>().state;
                                final List<CatalogModel> catalogs =
                                    searchCatalog(
                                  query,
                                  getCatalogByMembership(
                                    state.catalogs,
                                    selectedMembership != null &&
                                            MembershipType.values.any(
                                                (MembershipType element) =>
                                                    element ==
                                                    selectedMembership) &&
                                            authState is Unauthenticated
                                        ? MembershipType.values
                                            .firstWhereOrNull(
                                                (MembershipType element) =>
                                                    element ==
                                                    selectedMembership)
                                        : authState is Authenticated &&
                                                MembershipType.values.any(
                                                    (MembershipType element) {
                                                  return element.name ==
                                                      authState
                                                          .user.membershipLevel;
                                                })
                                            ? MembershipType.values
                                                .firstWhereOrNull(
                                                (MembershipType element) =>
                                                    element.name ==
                                                    authState
                                                        .user.membershipLevel,
                                              )
                                            : null,
                                  ),
                                );
                                if (authState is Authenticated) {
                                  if (authState.user.userMembership?.isActive ==
                                          false ||
                                      authState.user.membershipLevel ==
                                          'no membership') {
                                    return SliverToBoxAdapter(
                                      child: SizedBox(
                                        height: 400.h,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              'Пожалуйста выберите план для подписки',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                              textAlign: TextAlign.center,
                                            ),
                                            sized30,
                                            CstmBtn(
                                                text: 'Выбрать план',
                                                onTap: () {
                                                  context.pushNamed(
                                                    RoutesNames.changePlan,
                                                    extra: authState
                                                        .user.phoneNumber,
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                }
                                return MenuCard(
                                  catalogId: widget.catalogId ?? '',
                                  scrollController: _scrollController,
                                  catalogs: catalogs,
                                );
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MenuCard extends StatefulWidget {
  const MenuCard({
    super.key,
    required ScrollController scrollController,
    required this.catalogs,
    required this.catalogId,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final List<CatalogModel> catalogs;
  final String catalogId;
  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (BuildContext context, AuthState state) {
        return SliverPadding(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
          ),
          sliver: LiveSliverList(
            controller: widget._scrollController,
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
                    catalog: widget.catalogs[index],
                    function: () {
                      context.pushNamed(
                        RoutesNames.productMenu,
                        pathParameters: <String, String>{
                          'id': widget.catalogs[index].id.toString(),
                        },
                      );
                    },
                  ),
                ),
              );
            },
            itemCount: widget.catalogs.length,
          ),
        );
      },
    );
  }
}
