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
            child: ListView(shrinkWrap: true, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CustomBackButton(),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 280.h,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                      Radius.circular(24),
                    )),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                        fadeInCurve: Curves.bounceIn,
                        fit: BoxFit.fill,
                        imageUrl: model?.image ?? '',
                      ),
                    ),
                  ),
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
                  ProductTextDetailsField(
                    title: 'Марка',
                    subtitle: model?.name ?? '',
                  ),
                  ProductTextDetailsField(
                    title: 'Страна происхождения',
                    subtitle: model?.country ?? '',
                  ),
                  const ProductTextDetailsField(
                    title: 'Количество блоков',
                    subtitle: '4',
                  ),
                  ProductTextDetailsField(
                    title: 'Крепость',
                    subtitle: model?.strenght ?? '',
                  ),
                  ProductTextDetailsField(
                    title: 'Вкус',
                    subtitle: model?.taste ?? '',
                  ),
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
                      return CstmBtn(
                        text: 'Оформить заказ',
                        onTap: () async {
                          if (state.user.userMembership != null) {
                            if (state.user.userMembership?.isActive == false) {
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
                      );
                    } else {
                      return CstmBtn(
                        text: 'Оформить заказ',
                        onTap: () {
                          context.pushNamed(RoutesNames.login);
                        },
                      );
                    }
                  })
                ],
              ),
            ]),
          ),
        );
      },
    );
  }
}
