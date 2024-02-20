import 'package:fcc_app_front/export.dart';

class Order extends StatefulWidget {
  const Order({
    Key? key,
    this.showBack = false,
  }) : super(key: key);
  final bool showBack;

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<OrderCubit>().load();
    final Size size = MediaQuery.of(context).size;
    return Builder(
      builder: (BuildContext context) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 35.w,
                vertical: 20.h,
              ),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (BuildContext context, AuthState auth) {
                  return auth is Authenticated
                      ? BlocBuilder<OrderCubit, OrderState>(
                          builder: (BuildContext context, OrderState state) {
                            if (state.orders.isNotEmpty) {
                              return ListView.builder(
                                itemBuilder: (
                                  BuildContext context,
                                  int index,
                                ) {
                                  final OrderModel order = state.orders[index];
                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Заказы',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontSize: 20,
                                              ),
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context.pushNamed(
                                              RoutesNames.orderDetails,
                                              extra: order,
                                            );
                                          },
                                          child: SizedBox(
                                            height: size.height / 8.h,
                                            child: Row(
                                              children: <Widget>[
                                                Card(
                                                  elevation: 0.1,
                                                  clipBehavior: Clip.antiAlias,
                                                  child: Image.network(
                                                    'https://jebnalak.com/cdn/shop/files/blackfridayoffers-2023-09-18T181755.672_800x.png?v=1695050282',
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    Text(order.orderItems[index]
                                                        .productName),
                                                    Text(
                                                      '№ ${order.id}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                    Text(
                                                      'Статус: ${order.status}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]);
                                },
                                itemCount: 1,
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                sized20,
                                Text(
                                  'Детали заказа',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontSize: 20,
                                      ),
                                ),
                                sized20,
                                Text(
                                  'У вас нет заказов',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ],
                            );
                          },
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Вы не авторизованы',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            sized20,
                            Text(
                              'Сначала вам необходимо пройти аутентификацию, чтобы увидеть ссылку-приглашение.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 13,
                                    color: Theme.of(context).hintColor,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            sized20,
                            CstmBtn(
                              onTap: () {
                                context.pushNamed(RoutesNames.login);
                              },
                              text: 'Войти',
                              alignment: MainAxisAlignment.center,
                              textColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              color: Theme.of(context).canvasColor,
                            ),
                          ],
                        );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
