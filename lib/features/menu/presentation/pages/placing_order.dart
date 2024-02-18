import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/menu/data/models/address.dart';
import 'package:fcc_app_front/features/menu/presentation/bloc/order_bloc.dart';
import 'package:uuid/uuid.dart';

class PlacingOrderPage extends StatefulWidget {
  final ProductModel product;
  const PlacingOrderPage({
    required this.product,
    super.key,
  });

  @override
  State<PlacingOrderPage> createState() => _PlacingOrderPageState();
}

class _PlacingOrderPageState extends State<PlacingOrderPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

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

  int? selectedAddress;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, AddressOrderState>(
        builder: (BuildContext context, Object? state) {
      if (state is OrderSuccess) {
        Map<int, String> addressMap = <int, String>{
          for (Address address in state.addresses) address.id: address.address,
        };
        return Scaffold(
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
                    builder: (BuildContext context, AuthState authState) {
                      double price = widget.product.price;
                      if (authState is Authenticated) {
                        price = context
                                .watch<MembershipCubit>()
                                .state
                                .firstWhereOrNull((MembershipModel element) =>
                                    element.level == authState.user.membership)
                                ?.price ??
                            widget.product.price;
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
                        children: <Widget>[
                          const CustomBackButton(),
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
                          sized10,
                          DropdownButtonHideUnderline(
                            child: DropdownButton2<dynamic>(
                              isExpanded: true,
                              hint: Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.list,
                                    size: 16,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Адрес пункта выдачи',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              items: addressMap.entries
                                  .map<DropdownMenuItem<dynamic>>(
                                      (MapEntry<int, String> entry) =>
                                          DropdownMenuItem<dynamic>(
                                            value: entry.key,
                                            child: Text(
                                              entry.value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                  .toList(),
                              value: selectedAddress,
                              onChanged: (dynamic value) {
                                setState(() {
                                  selectedAddress = value;
                                });
                              },
                              buttonStyleData: ButtonStyleData(
                                height: 50,
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.1),
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 14,
                                iconEnabledColor: Colors.black,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness:
                                      MaterialStateProperty.all<double>(6),
                                  thumbVisibility:
                                      MaterialStateProperty.all<bool>(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                            ),
                          ),
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
                            hintText: 'Телефон',
                            textInputType: TextInputType.number,
                            initialValue: authState is Authenticated
                                ? authState.user.phoneNumber
                                : null,
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
                            'Сумма',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          sized10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Дегустационный набор',
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
                                '${widget.product.price} \u20BD',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Доставка в пункт выдачи',
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
                                '0 Р',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Итого',
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
                                '${widget.product.price} \u20BD',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                          sized30,
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

                                if (selectedAddress == null) {
                                  ApplicationSnackBar.showErrorSnackBar(
                                      context,
                                      'Пожалуйста, выберите адрес',
                                      0.9,
                                      const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      1);
                                  return;
                                }
                                if (_formKey.currentState!.validate() &&
                                    validateMobile() == null &&
                                    russianValidator(
                                      nameController.text,
                                    )) {
                                  final OrderModel? order =
                                      await OrderRepo.placeOrder(
                                    productId: const Uuid().v4(),
                                    address: selectedAddress ?? 0,
                                    name: nameController.text,
                                    phone: maskFormatter
                                        .getMaskedText()
                                        .replaceAll(' ', '')
                                        .replaceAll('-', ''),
                                    email: emailController.text,
                                  );
                                  if (order != null && context.mounted) {
                                    canPopThenPop(context);
                                    context
                                        .read<SelectedProductsCubit>()
                                        .addProduct(null);
                                    context.pushNamed(
                                      RoutesNames.orderConfirm,
                                    );
                                  }
                                } else {
                                  if (selectedAddress == null) {
                                    ApplicationSnackBar.showErrorSnackBar(
                                        context,
                                        'Пожалуйста, введите адрес',
                                        0.9,
                                        const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        1);
                                  }
                                  if (nameController.text == '') {
                                    ApplicationSnackBar.showErrorSnackBar(
                                      context,
                                      'Пожалуйста, введите имя',
                                      1,
                                      const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      3,
                                    );
                                  }
                                  if (!russianValidator(
                                    nameController.text,
                                  )) {
                                    ApplicationSnackBar.showErrorSnackBar(
                                        context,
                                        'Пожалуйста, используйте в имени только русские буквы',
                                        0.9,
                                        const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        2);
                                  }
                                  if (validateMobile() != null) {
                                    ApplicationSnackBar.showErrorSnackBar(
                                        context,
                                        validateMobile() ??
                                            'Пожалуйста, введите номер телефона',
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
      }

      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    });
  }
}
