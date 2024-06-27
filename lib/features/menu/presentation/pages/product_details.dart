import 'package:fcc_app_front/export.dart';

class ProductDetails extends StatelessWidget {
  final Product? model;
  const ProductDetails({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
        BuildContext context,
        BoxConstraints constraints,
      ) {
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
                    left: 30 + (availableWidth - 600) / 2,
                    right: 30 + (availableWidth - 600) / 2,
                  ),
            child: ListView(children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const CustomBackButton(),
                    const SizedBox(
                      height: 20,
                    ),
                    Card(
                        clipBehavior: Clip.antiAlias,
                        child: ClipRect(
                          child: Container(
                            height: 280,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  30.r,
                                ),
                              ),
                            ),
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: model!.image,
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      model?.name ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      model?.description ?? '',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    if (_shouldDisplayField(model?.mark ?? ''))
                    ProductTextDetailsField(
                      title: 'Марка',
                      subtitle: model?.mark ?? '',
                    ),
                    if (_shouldDisplayField(model?.country ?? ''))
                    ProductTextDetailsField(
                      title: 'Страна происхождения',
                      subtitle: model?.country ?? '',
                    ),
                    const ProductTextDetailsField(
                      title: 'Количество к оформлению',
                      subtitle: '4',
                    ),
                  if (_shouldDisplayField(model?.strenght ?? ''))
                    ProductTextDetailsField(
                      title: 'Крепость',
                      subtitle: model?.strenght ?? '',
                    ),
                    if (_shouldDisplayField(model?.taste ?? ''))
                    ProductTextDetailsField(
                      title: 'Вкус',
                      subtitle: model?.taste ?? '',
                    ),
                    if (_shouldDisplayField(model?.format ?? ''))
                    ProductTextDetailsField(
                      title: 'Формат',
                      subtitle: model?.format ?? '',
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    BlocBuilder<AuthCubit, AuthState>(
                        builder: (BuildContext context, AuthState state) {
                      if (state is Authenticated) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CstmBtn(
                            text: 'Оформить заказ',
                            onTap: () async {
                              if (state.user.userMembership != null) {
                                if (state.user.userMembership?.isActive ==
                                    false) {
                                  ApplicationSnackBar.showErrorSnackBar(
                                    context,
                                    'Подписка не активна,пожалуйста,продлите подписку',
                                    0.9,
                                    const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    1,
                                  );
                                  context.go(RoutesNames.introCatalog);
                                  return;
                                }
                              }

                              if (state is Unauthenticated) {
                                context.pushNamed(RoutesNames.login);
                                return;
                              }

                              context.goNamed(
                                RoutesNames.placeOrder,
                                extra: model,
                              );
                            },
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: CstmBtn(
                            text: 'Оформить заказ',
                            onTap: () {
                              context.pushNamed(RoutesNames.login);
                            },
                          ),
                        );
                      }
                    })
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }

  bool _shouldDisplayField(String value) {
    return value != '-' && value.isNotEmpty;
  }
}
