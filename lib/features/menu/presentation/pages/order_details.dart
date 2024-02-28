import 'package:fcc_app_front/export.dart';

class OrderDetails extends StatelessWidget {
  final OrderModel? order;

  const OrderDetails({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
              "Заказ от ${DateFormat('dd.MM.yyyy').format(order?.createdAt ?? DateTime.now())}",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),
            sized10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Статуз заказа',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
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
                  order?.status ?? '',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                      ),
                ),
              ],
            ),
            sized10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Доставка в пункт выдачи',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
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
                  DateFormat('dd.MM.yyyy').format(
                    order?.createdAt ?? DateTime.now(),
                  ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                      ),
                ),
              ],
            ),
            sized30,
            Text(
              'Адрес пункта выдачи',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
            ),

            sized20,
            Text(order?.deliveryPoint?.address ?? ''),

            Text(
              order?.pickupAddress ?? '',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
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
      ),
    );
  }
}
