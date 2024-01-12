import 'package:dotted_line/dotted_line.dart';
import 'package:fcc_app_front/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/editing_address.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/order_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../shared/config/routes.dart';
import '../../../../shared/constants/colors/color.dart';
import '../../../../shared/constants/widgets/custom_back.dart';
import '../../../../shared/constants/widgets/sizedbox.dart';
import '../../../../shared/widgets/buttons/cstm_btn.dart';
import '../../../../shared/widgets/on_tap_scale.dart';
import '../../../../shared/widgets/textfields/custom_form_field.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({
    Key? key,
    this.showBack = false,
  }) : super(key: key);
  final bool showBack;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditingAddress(),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 35.w,
                vertical: 20.h,
              ),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, auth) {
                  return auth is Authenticated
                      ? BlocBuilder<OrderCubit, OrderState>(
                          builder: (context, state) {
                            if (state.orders.isNotEmpty) {
                              final order = state.orders.last;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (widget.showBack) CustomBackButton(),
                                  sized20,
                                  Text(
                                    "Детали заказа",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          fontSize: 20,
                                        ),
                                  ),
                                  sized30,
                                  Text(
                                    "Заказ от ${DateFormat('dd.MM.yyyy').format(order.date)}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  sized10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Статуз заказа",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 12),
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
                                        "Собирается",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  sized10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Доставка в пункт выдачи",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 12),
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
                                          order.date,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  sized30,
                                  Text(
                                    "Адрес пункта выдачи",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  sized20,
                                  Text(
                                    order.address,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                  ),
                                  sized10,
                                  BlocBuilder<EditingAddress, bool>(
                                    builder: (context, state) {
                                      if (state) {
                                        return CustomFormField(
                                          controller: addressController,
                                          initialValue: order.address,
                                          textInputAction: TextInputAction.next,
                                          hintText: 'Адрес пункта выдачи',
                                          validator:
                                              FormBuilderValidators.compose(
                                            [
                                              FormBuilderValidators.required(
                                                errorText: 'Заполните это поле',
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                  OnTapScaleAndFade(
                                    onTap: () {
                                      if (context
                                          .read<EditingAddress>()
                                          .state) {
                                        if (addressController.text != '') {
                                          context
                                              .read<EditingAddress>()
                                              .change(false);

                                          context
                                              .read<OrderCubit>()
                                              .changeAddress(
                                                addressController.text,
                                              );
                                        }
                                      } else {
                                        context
                                            .read<EditingAddress>()
                                            .change(true);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 5,
                                        bottom: 5,
                                        right: 5,
                                      ),
                                      child: Text(
                                        "Изменить",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                              color: textColor,
                                            ),
                                      ),
                                    ),
                                  ),
                                  sized30,
                                  Text(
                                    "Местонахождения заказа",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  sized20,
                                  Text(
                                    order.address,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                sized20,
                                Text(
                                  "Детали заказа",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontSize: 20,
                                      ),
                                ),
                                sized20,
                                Text(
                                  "У вас нет заказов",
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
                          children: [
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
                              text: "Войти",
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
      }),
    );
  }
}
