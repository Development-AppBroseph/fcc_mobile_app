import 'package:fcc_app_front/export.dart';

class CatalogProductDetails extends StatelessWidget {
  final Product model;
  const CatalogProductDetails({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CatalogCubit>(
      create: (BuildContext context) => CatalogCubit(),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double availableWidth = constraints.maxWidth;
          return Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: availableWidth < 600
                  ? const EdgeInsets.only(
                      left: 30,
                      right: 30,
                    )
                  : EdgeInsets.only(
                      bottom: 30 + (availableWidth - 600) / 2,
                      top: 30 + (availableWidth - 600) / 2,
                      left: 30 + (availableWidth - 600) / 2,
                      right: 30 + (availableWidth - 600) / 2,
                    ),
              child: SafeArea(
                child: ListView(shrinkWrap: true, children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const CustomBackButton(),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 280,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        )),
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            imageUrl: model.image,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        model.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        model.description,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProductTextDetailsField(
                        title: 'Марка',
                        subtitle: model.name,
                      ),
                      ProductTextDetailsField(
                        title: 'Страна происхождения',
                        subtitle: model.country,
                      ),
                      const ProductTextDetailsField(
                        title: 'Количество блоков',
                        subtitle: '4',
                      ),
                      ProductTextDetailsField(
                        title: 'Крепость',
                        subtitle: model.strenght,
                      ),
                      ProductTextDetailsField(
                        title: 'Вкус',
                        subtitle: model.taste,
                      ),
                      ProductTextDetailsField(
                        title: 'Формат',
                        subtitle: model.format,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (BuildContext context, AuthState state) {
                          if (state is Authenticated) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 40,
                              ),
                              child: CstmBtn(
                                  text: 'Оформить заказ',
                                  onTap: () async {
                                    if (state.user.userMembership?.isActive ==
                                        false) {
                                      ApplicationSnackBar.showErrorSnackBar(
                                          context,
                                          'Подписка не активна,пожалуйста,продлите подписку',
                                          1,
                                          const EdgeInsets.all(16),
                                          2);
                                      context.go(Routes.introCatalog);
                                    }
                                  }),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: 40,
                              ),
                              child: CstmBtn(
                                  text: 'Оформить заказ',
                                  onTap: () async {
                                    context.go(Routes.introCatalog);
                                  }),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
