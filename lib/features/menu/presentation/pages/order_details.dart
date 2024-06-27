import 'package:fcc_app_front/export.dart';

class OrderDetails extends StatelessWidget {
  final OrderModel? order;

  const OrderDetails({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double boxWidth = constraints.maxWidth;
        return SafeArea(
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
            child: ListView(children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  sized20,
                  const Row(
                    children: <Widget>[
                      CustomBackButton(),
                    ],
                  ),
                  sized30,
                  Text(
                    'Заказ №${order?.id}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  sized10,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Статус: ',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          convertOrderStatus(
                            order?.status ?? '',
                          ),
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),

                  sized10,
                  SizedBox(
                    height: size.height / 3,
                    width: double.infinity,
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      child: CachedNetworkImage(
                          fadeInCurve: Curves.easeInOutBack,
                          fit: BoxFit.fitWidth,
                          imageUrl: order?.orderItems.first.productPhoto ?? ''),
                    ),
                  ),

                  sized20,
                  InkWell(
                    hoverColor: Theme.of(context).primaryColor,
                    onTap: () async {
                      final Product? product =
                          await context.read<OrderCubit>().getProductbyId(
                                productUuid:
                                    order?.orderItems.last.productUuid ?? '',
                              );

                      if (context.mounted) {
                        context.pushNamed(
                          RoutesNames.productDetails,
                          extra: product,
                        );
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Перейти к товару'),
                        Icon(
                          Icons.arrow_right_alt_outlined,
                          size: 32,
                        )
                      ],
                    ),
                  ),
                  sized30,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Количество блоков',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Expanded(
                        child: DottedLine(
                          dashRadius: 10,
                          dashColor: hintColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '4',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                  sized10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Статус доставки',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Expanded(
                        child: DottedLine(
                          dashRadius: 10,
                          dashColor: hintColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        convertDeliveryStatus(order?.deliveryStatus ?? ''),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ],
                  ),
                  sized10,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Трек-номер',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 14,
                            ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Expanded(
                        child: DottedLine(
                          dashRadius: 10,
                          dashColor: hintColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      order?.trackNumber != null && order!.trackNumber.isNotEmpty
                          ? GestureDetector(
                        onTap: () async {
                          await Clipboard.setData(
                            ClipboardData(
                              text: order?.trackNumber ?? '',
                            ),
                          ).then((_) {
                            ApplicationSnackBar.showErrorSnackBar(
                              context,
                              'Трек-номер скопирован в буфер обмена',
                              1,
                              const EdgeInsets.all(16),
                              1,
                              false,
                            );
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              '№${order?.trackNumber}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(width: 5),
                            SvgPicture.asset(
                              'assets/copy.svg',
                              colorFilter:
                              ColorFilter.mode(
                                Theme.of(context)
                                    .canvasColor,
                                BlendMode.srcIn,
                              ),
                              height: 18,
                            ),
                          ],
                        ),
                      )
                          : const SizedBox.shrink(),
                    ],
                  ),
                  sized30,
                  const Text(
                    'Адрес доставки',
                  ),

                  sized20,
                  Text(
                    order?.deliveryPoint ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),

                  sized40,
                ],
              ),
            ]),
          ),
        );
      },
    );
  }

  String convertDeliveryStatus(String orderStatus) {
    switch (orderStatus) {
      case 'WAITING':
        return 'Ожидает отправки';
      case 'PROCESS':
        return 'В пути';
      case 'SUCCESS':
        return 'Доставлен';
      default:
        return 'Статус неизвестен';
    }
  }

  String convertOrderStatus(String orderStatus) {
    switch (orderStatus) {
      case 'PROCESS':
        return 'Принят';
      case 'READY':
        return 'Собран';
      case 'DELIVERY':
        return 'Передан в доставку';
      default:
        return 'Статус неизвестен';
    }
  }
}
