import 'package:fcc_app_front/export.dart';

class CatalogMenuProfile extends StatefulWidget {
  const CatalogMenuProfile({
    required this.type,
    super.key,
  });
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
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<SearchCubit>(
          create: (BuildContext context) => SearchCubit(),
        ),
        BlocProvider<ProductCubit>(
          create: (BuildContext context) => ProductCubit(),
        ),
        BlocProvider<CatalogCubit>(
          create: (BuildContext context) => CatalogCubit()
            ..getAllCatalogsById((widget.type.index + 1).toString()),
        ),
        BlocProvider<MembershipCubit>(create: (BuildContext context) => MembershipCubit())
      ],
      child: Builder(
        builder: (BuildContext context) {
          return LayoutBuilder(
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
                    child: CustomScrollView(
                      slivers: <Widget>[
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const CustomBackButton(),
                              sized20,
                              Text(
                                membershipNames[widget.type]?.toUpperCase() ??
                                    membershipNames.values.first.toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
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
                                final List<CatalogModel> catalogs =
                                    searchCatalog(
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
                                    itemBuilder: (BuildContext context,
                                        int index,
                                        Animation<double> animation) {
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
                                            catalog: state.catalogs[index],
                                            function: () {
                                              context.pushNamed(
                                                RoutesNames
                                                    .catalogProductProfile,
                                                extra: MultipleCubits(
                                                  cubits: <String,
                                                      Cubit<Equatable>>{
                                                    'productCubit': BlocProvider
                                                        .of<ProductCubit>(
                                                            context),
                                                    'catalogCubit': BlocProvider
                                                        .of<CatalogCubit>(
                                                            context),
                                                  },
                                                ),
                                                pathParameters: <String,
                                                    String>{
                                                  'id': state.catalogs[index].id
                                                      .toString(),
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: state.catalogs.length,
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
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
