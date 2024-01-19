import 'package:fcc_app_front/export.dart';

class CatalogMenu extends StatefulWidget {
  final MembershipType type;

  const CatalogMenu({
    required this.type,
    Key? key,
  }) : super(key: key);

  @override
  State<CatalogMenu> createState() => _CatalogMenuState();
}

class _CatalogMenuState extends State<CatalogMenu> {
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
      providers: <SingleChildWidget>[
        BlocProvider(
          create: (BuildContext context) => SearchCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ProductCubit()
            ..load(
              isPublic: true,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => CatalogCubit()
            ..load(
              isPublic: true,
            ),
        ),
      ],
      child: Builder(builder: (BuildContext context) {
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
                          membershipNames[widget.type]?.toUpperCase() ?? membershipNames.values.first.toUpperCase(),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
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
                  BlocBuilder<SearchCubit, String?>(
                    builder: (BuildContext context, String? query) {
                      return BlocBuilder<CatalogCubit, CatalogState>(
                        builder: (BuildContext context, CatalogState state) {
                          final List<CatalogModel> catalogs = searchCatalog(
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
                              showItemInterval: const Duration(milliseconds: 150),
                              showItemDuration: const Duration(milliseconds: 200),
                              itemBuilder: (BuildContext context, int index, Animation<double> animation) =>
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
                                        RoutesNames.catalogProductMenu,
                                        extra: MultipleCubits(
                                          cubits: <String, Cubit<Equatable>>{
                                            'productCubit': BlocProvider.of<ProductCubit>(context),
                                            'catalogCubit': BlocProvider.of<CatalogCubit>(context),
                                          },
                                        ),
                                        pathParameters: <String, String>{
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
