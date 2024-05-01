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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double boxWidth = constraints.maxWidth;

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
                                  final List<OrderModel> order = state.orders;

                                  return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            context.pushNamed(
                                              RoutesNames.orderDetails,
                                              extra: order[index],
                                            );
                                          },
                                          child: SizedBox(
                                            height: size.height / 6.h,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Card(
                                                    elevation: 0.1,
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: CachedNetworkImage(
                                                      imageBuilder: (BuildContext
                                                              context,
                                                          ImageProvider<Object>
                                                              imageProvider) {
                                                        return Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      imageUrl: order[index]
                                                          .orderItems
                                                          .map((OrderItem e) {
                                                            return e
                                                                .productPhoto;
                                                          })
                                                          .toString()
                                                          .replaceAll('(', '')
                                                          .replaceAll(')', ''),
                                                      width: 100.w,
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20.w,
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Text(
                                                        '№ ${order[index].id}',
                                                      ),
                                                      Text(
                                                        order[index]
                                                            .orderItems
                                                            .map((OrderItem e) {
                                                              return e
                                                                  .productName;
                                                            })
                                                            .toString()
                                                            .replaceAll(
                                                              '(',
                                                              '',
                                                            )
                                                            .replaceAll(
                                                              ')',
                                                              '',
                                                            ),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                      ),
                                                      Text(
                                                        'Статус: ${convertOrderStatus(order[index].status)}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ]);
                                },
                                itemCount: state.orders.length,
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
                              textColor: Theme.of(context).primaryColorDark,
                              color: Theme.of(context).primaryColor,
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

  String convertOrderStatus(String orderStatus) {
    switch (orderStatus) {
      case 'PROCESS':
        return 'Принят';
      case 'READY':
        return 'Собран';
      case 'DELIVERED':
        return 'Передан на доставку';
      default:
        return 'Статус неизвестен';
    }
  }
}
