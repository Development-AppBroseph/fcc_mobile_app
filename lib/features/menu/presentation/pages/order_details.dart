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
                      Text(
                        convertOrderStatus(
                          order?.status ?? '',
                        ),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
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
                      Text(
                        '№${order?.trackNumber}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 14,
                            ),
                      ),
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

                  sized10,
                  // BlocBuilder<EditingAddress, bool>(
                  //   builder: (BuildContext context, bool state) {
                  //     if (state) {
                  //       return CustomFormField(
                  //         controller: addressController,
                  //         initialValue: order.address,
                  //         textInputAction: TextInputAction.next,
                  //         hintText: 'Адрес пункта выдачи',
                  //         validator: FormBuilderValidators.compose(
                  //           <FormFieldValidator<String>>[
                  //             FormBuilderValidators.required(
                  //               errorText: 'Заполните это поле',
                  //             ),
                  //           ],
                  //         ),
                  //       );
                  //     }
                  //     return const SizedBox.shrink();
                  //   },
                  // ),
                  // OnTapScaleAndFade(
                  // onTap: () {
                  //   if (context.read<EditingAddress>().state) {
                  //     if (addressController.text != '') {
                  //       context.read<EditingAddress>().change(false);

                  //       context.read<OrderCubit>().changeAddress(
                  //             addressController.text,
                  //           );
                  //     }
                  //   } else {
                  //     context.read<EditingAddress>().change(true);
                  //   }
                  // },
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //       top: 5,
                  //       bottom: 5,
                  //       right: 5,
                  //     ),
                  //     child: Text(
                  //       'Изменить',
                  //       style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  //             fontWeight: FontWeight.w400,
                  //             fontSize: 12,
                  //             color: textColor,
                  //           ),
                  //     ),
                  //   ),
                  // ),
                  sized30,
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
        return 'Передан в службу доставки';
      default:
        return 'Статус неизвестен';
    }
  }
}
