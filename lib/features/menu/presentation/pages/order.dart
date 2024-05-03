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
                                            Navigator.of(context).push(
                                              MaterialPageRoute<dynamic>(
                                                  builder:
                                                      (BuildContext context) {
                                                return OrderDetails(
                                                  order: order[index],
                                                );
                                              }),
                                            );
                                          },
                                          child: SizedBox(
                                            height: size.height / 9.h,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  child: SizedBox(
                                                    height: 90,
                                                    child: order[index]
                                                                .orderItems[
                                                                    index]
                                                                .productPhoto !=
                                                            null
                                                        ? ClipRect(
                                                            child: Container(
                                                              height: 90,
                                                              width: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                    30.r,
                                                                  ),
                                                                ),
                                                              ),
                                                              child:
                                                                  CachedNetworkImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                imageUrl: order[
                                                                        index]
                                                                    .orderItems
                                                                    .map(
                                                                        (OrderItem
                                                                            e) {
                                                                      return e
                                                                          .productPhoto;
                                                                    })
                                                                    .toString()
                                                                    .replaceAll(
                                                                        '(', '')
                                                                    .replaceAll(
                                                                        ')',
                                                                        ''),
                                                              ),
                                                            ),
                                                          )
                                                        : AspectRatio(
                                                            aspectRatio: 1,
                                                            child: Container(
                                                              height: double
                                                                  .infinity,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                color:
                                                                    primaryColorLight,
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .smoking_rooms,
                                                                ),
                                                              ),
                                                            ),
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
