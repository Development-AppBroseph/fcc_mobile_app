import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/menu/presentation/pages/choose_address.dart';

class PlacingOrderPage extends StatefulWidget {
  final ProductModel? product;
  const PlacingOrderPage({
    this.product,
    super.key,
  });

  @override
  State<PlacingOrderPage> createState() => _PlacingOrderPageState();
}

class _PlacingOrderPageState extends State<PlacingOrderPage> {
  String selectedAddressByUser = '';
  int selectedAddressId = 0;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    initialText: '+7 ',
    mask: '+7 ###-###-##-##',
    filter: <String, RegExp>{
      '#': RegExp(r'[0-9]'),
    },
  );
  String? validateMobile() {
    final String value = maskFormatter.getMaskedText();
    if (value.length <= 10) {
      return 'Пожалуйста, введите корректный номер мобильного телефона';
    }
    return null;
  }

  int? selectedAddress;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double boxWidth = constraints.constrainWidth();

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
              child: FormBuilder(
                key: _formKey,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  reverse: true,
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (BuildContext context, AuthState authState) {
                      double price = widget.product?.price ?? 0;

                      if (authState is Authenticated) {
                        price = context
                                .watch<MembershipCubit>()
                                .state
                                .firstWhereOrNull((MembershipModel element) =>
                                    element.level ==
                                    authState.user.membershipLevel)
                                ?.price ??
                            widget.product?.price ??
                            0;
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          sized20,
                          Text(
                            'Оформление заказа',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontSize: 20,
                                ),
                          ),
                          sized20,
                          Text(
                            'Адрес пункта выдачи',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                          sized30,
                          Column(
                            children: <Widget>[
                              InkWell(
                                  onTap: () async {
                                    final Map<int?, String?>? selectedAddress =
                                        await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChooseAddress()),
                                    );

                                    setState(() {
                                      selectedAddressId =
                                          selectedAddress?.keys.first ?? 0;
                                      selectedAddressByUser =
                                          selectedAddress?.values.first ?? '';
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Выберите адрес',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontWeight: FontWeight.w400,
                                                ),
                                            textAlign: TextAlign.center,
                                          ),
                                          const Icon(Icons.chevron_right),
                                        ],
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          sized30,
                          RichText(
                              text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Выбран aдрес: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w200,
                                    )
                                    .copyWith(
                                      fontFamily: 'Rubik',
                                    ),
                              ),
                              TextSpan(
                                text: '$selectedAddressByUser ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          )),
                          sized20,
                          Text(
                            'Получатель',
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                              <FormFieldValidator<String>>[
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
                            hintText: '+7 (000) 000-00-00',
                            validator: FormBuilderValidators.compose(
                              <FormFieldValidator<String>>[
                                FormBuilderValidators.required(
                                  errorText: 'Заполните это поле',
                                ),
                              ],
                            ),
                            textInputType: TextInputType.number,
                            initialValue: maskFormatter.getMaskedText(),
                            textInputFormatter: <TextInputFormatter>[
                              maskFormatter,
                            ],
                          ),
                          sized10,
                          CustomFormField(
                            controller: emailController,
                            textInputAction: TextInputAction.done,
                            hintText: 'Эл. почта',
                            validator: FormBuilderValidators.compose(
                              <FormFieldValidator<String>>[
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
                            'Переходя к оплате, вы принимаете условия доставки и подтверждаете достоверность ваших данных.',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
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

                                if (selectedAddressByUser.isEmpty) {
                                  ApplicationSnackBar.showErrorSnackBar(
                                      context,
                                      'Пожалуйста, выберите адрес',
                                      0.9,
                                      const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      2);
                                  return;
                                }
                                if (phoneController.text.length < 10) {
                                  ApplicationSnackBar.showErrorSnackBar(
                                      context,
                                      'Пожалуйста, введите корректный номер мобильного телефона',
                                      0.9,
                                      const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      2);
                                  return;
                                }
                                if (_formKey.currentState!.validate() &&
                                    phoneController.text.length >= 10) {
                                  final (OrderModel?, String?) order =
                                      await OrderRepo.placeOrder(
                                    product: widget.product!,
                                    address: selectedAddressId,
                                    name: nameController.text,
                                    phone: maskFormatter
                                        .getMaskedText()
                                        .replaceAll(' ', '')
                                        .replaceAll('-', ''),
                                    email: emailController.text,
                                  );

                                  if (order.$2 != null && context.mounted) {
                                    ApplicationSnackBar.showErrorSnackBar(
                                        context,
                                        order.$2 ?? '',
                                        1,
                                        const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        3);
                                    return;
                                  }

                                  if (order.$1 != null && context.mounted) {
                                    canPopThenPop(context);
                                    context
                                        .read<SelectedProductsCubit>()
                                        .addProduct(null);
                                    context.pushNamed(
                                      RoutesNames.orderConfirm,
                                    );
                                  }
                                } else {
                                  if (validateMobile() != null) {
                                    ApplicationSnackBar.showErrorSnackBar(
                                        context,
                                        validateMobile() ??
                                            'Пожалуйста, введите номер телефона',
                                        0.9,
                                        const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        3);
                                  }
                                }
                              } catch (e) {
                                if (e is OrderException && context.mounted) {
                                  ApplicationSnackBar.showErrorSnackBar(
                                    context,
                                    'Bы уже оформили заказ в этом месяце',
                                    0.9,
                                    const EdgeInsets.symmetric(horizontal: 10),
                                    2,
                                  );
                                }
                              }
                            },
                            text: 'Оформить доставку',
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
