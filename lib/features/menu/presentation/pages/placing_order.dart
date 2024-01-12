import 'package:collection/collection.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:fcc_app_front/features/catalog/presentation/cubit/membership_cubit.dart';
import 'package:fcc_app_front/features/menu/data/datasources/order_exception.dart';
import 'package:fcc_app_front/shared/constants/widgets/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:fcc_app_front/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fcc_app_front/features/menu/data/repositories/order_repo.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/selected_products_cubit.dart';
import 'package:fcc_app_front/shared/config/utils/pop_possible.dart';
import 'package:fcc_app_front/shared/constants/hive.dart';
import 'package:fcc_app_front/shared/utils/russian_validator.dart';
import 'package:fcc_app_front/shared/widgets/textfields/custom_form_field.dart';

import '../../../../shared/config/routes.dart';
import '../../../../shared/constants/colors/color.dart';
import '../../../../shared/constants/widgets/custom_back.dart';
import '../../../../shared/constants/widgets/sizedbox.dart';
import '../../../../shared/widgets/buttons/cstm_btn.dart';
import '../../../../shared/widgets/snackbar.dart';

class PlacingOrderPage extends StatefulWidget {
  const PlacingOrderPage({
    Key? key,
  }) : super(key: key);
  @override
  State<PlacingOrderPage> createState() => _PlacingOrderPageState();
}

class _PlacingOrderPageState extends State<PlacingOrderPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final addressController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(
    initialText: '+7 ',
    mask: '+7 ###-###-##-##',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );
  String? validateMobile() {
    final value = maskFormatter.getMaskedText();
    String patttern =
        r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)';
    RegExp regExp = RegExp(patttern);
    if (value.isEmpty) {
      return 'Пожалуйста, введите номер мобильного телефона';
    } else if (!regExp.hasMatch(value)) {
      return 'Пожалуйста, введите действительный номер мобильного телефона';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final product = context.read<SelectedProductsCubit>().state.product;
    if (product == null) return Container();
    return BlocProvider(
      create: (context) => MembershipCubit()..load(),
      child: Builder(builder: (context) {
        return KeyboardDismisser(
          child: Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 35.w,
                  vertical: 20.h,
                ),
                child: FormBuilder(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    reverse: true,
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, authState) {
                        double price = product.price;
                        if (authState is Authenticated) {
                          price = context
                                  .watch<MembershipCubit>()
                                  .state
                                  .firstWhereOrNull((element) =>
                                      element.level ==
                                      authState.user.membership)
                                  ?.price ??
                              product.price;
                          if (maskFormatter.getMaskedText() == '') {
                            maskFormatter.updateMask(
                              newValue: TextEditingValue(
                                text: authState.user.phoneNumber,
                              ),
                            );
                          }
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomBackButton(),
                            sized20,
                            Text(
                              "Оформление заказа",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontSize: 20,
                                  ),
                            ),
                            sized20,
                            Text(
                              "Адрес пункта выдачи",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            sized10,
                            CustomFormField(
                              controller: addressController,
                              initialValue: Hive.box(HiveStrings.userBox)
                                      .containsKey(HiveStrings.address)
                                  ? Hive.box(HiveStrings.userBox)
                                      .get(HiveStrings.address)
                                  : null,
                              textInputAction: TextInputAction.next,
                              hintText: 'Адрес пункта выдачи',
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(
                                    errorText: 'Заполните это поле',
                                  ),
                                ],
                              ),
                            ),
                            sized20,
                            Text(
                              "Получатель",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                            sized10,
                            CustomFormField(
                              controller: nameController,
                              initialValue: authState is Authenticated
                                  ? authState.user.firstName
                                  : null,
                              textInputAction: TextInputAction.next,
                              hintText: 'Введите имя',
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(
                                    errorText: 'Заполните это поле',
                                  ),
                                ],
                              ),
                            ),
                            sized10,
                            CustomFormField(
                              controller: phoneController,
                              textInputAction: TextInputAction.next,
                              hintText: 'Телефон',
                              textInputType: TextInputType.number,
                              initialValue: authState is Authenticated
                                  ? authState.user.phoneNumber
                                  : null,
                              textInputFormatter: [
                                maskFormatter,
                              ],
                            ),
                            sized10,
                            CustomFormField(
                              controller: emailController,
                              textInputAction: TextInputAction.done,
                              hintText: "Эл. почта",
                              validator: FormBuilderValidators.compose(
                                [
                                  FormBuilderValidators.required(
                                      errorText: 'Заполните это поле'),
                                  FormBuilderValidators.email(
                                      errorText:
                                          'Неправильный электронной почты'),
                                ],
                              ),
                            ),
                            sized40,
                            Text(
                              "Сумма",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            sized10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Дегустационный набор",
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
                                  '$price \u20BD',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  "0 Р",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Итого",
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
                                  '$price \u20BD',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                            sized30,
                            Text(
                              "Переходя к оплате, вы принимаете условия доставки и подтверждаете достоверность ваших данных.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontSize: 12,
                                    color: Theme.of(context).hintColor,
                                  ),
                            ),
                            sized20,
                            CstmBtn(
                              width: double.infinity,
                              onTap: () async {
                                try {
                                  if (context.read<AuthCubit>().state
                                      is Unauthenticated) {
                                    context.pushNamed(RoutesNames.login);
                                    return;
                                  }
                                  if (_formKey.currentState!.validate() &&
                                      validateMobile() == null &&
                                      russianValidator(
                                        nameController.text,
                                      )) {
                                    final order = await OrderRepo.placeOrder(
                                      product,
                                      addressController.text,
                                      nameController.text,
                                      maskFormatter
                                          .getMaskedText()
                                          .replaceAll(' ', '')
                                          .replaceAll('-', ''),
                                      emailController.text,
                                    );
                                    if (order != null && context.mounted) {
                                      canPopThenPop(context);
                                      canPopThenPop(context);
                                      context
                                          .read<SelectedProductsCubit>()
                                          .addProduct(null);
                                      context.pushNamed(
                                        RoutesNames.orderConfirm,
                                      );
                                    }
                                  } else {
                                    if (addressController.text == '') {
                                      ErrorSnackBar.showErrorSnackBar(
                                          context,
                                          "Пожалуйста, введите адрес",
                                          0.9,
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          1);
                                    }
                                    if (nameController.text == '') {
                                      ErrorSnackBar.showErrorSnackBar(
                                        context,
                                        "Пожалуйста, введите имя",
                                        1,
                                        const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        3,
                                      );
                                    }
                                    if (!russianValidator(
                                      nameController.text,
                                    )) {
                                      ErrorSnackBar.showErrorSnackBar(
                                          context,
                                          "Пожалуйста, используйте в имени только русские буквы",
                                          0.9,
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          2);
                                    }
                                    if (validateMobile() != null) {
                                      ErrorSnackBar.showErrorSnackBar(
                                          context,
                                          validateMobile() ??
                                              "Пожалуйста, введите номер телефона",
                                          0.9,
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          1);
                                    }
                                  }
                                } catch (e) {
                                  if (e is OrderException && context.mounted) {
                                    showErrorSnackbar(
                                      context,
                                      'Bы уже оформили заказ в этом месяце',
                                    );
                                  }
                                }
                              },
                              text: "Оформить доставку",
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
