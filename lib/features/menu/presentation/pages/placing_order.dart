import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/menu/data/models/address.dart';
import 'package:fcc_app_front/features/menu/presentation/bloc/order_bloc.dart';

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
                  double price = widget.product?.price ?? 0;

                  if (authState is Authenticated) {
                    price = context
                            .watch<MembershipCubit>()
                            .state
                            .firstWhereOrNull((MembershipModel element) =>
                                element.level == authState.user.membershipLevel)
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
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontSize: 20,
                                ),
                      ),
                      sized20,
                      Text(
                        'Адрес пункта выдачи',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      sized10,
                      TextField(
                        onSubmitted: (address) {
                          context
                              .read<OrderBloc>()
                              .add(FetchAllAddreses(address: address));
                        },
                        textInputAction: TextInputAction.search,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                        decoration: InputDecoration(
                          hintText: 'Поиск адреса',
                          hintStyle:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                        controller: addressController,
                      ),
                      BlocBuilder<OrderBloc, AddressOrderState>(
                        builder: (context, state) {
                          if (state is OrderSuccess) {
                            return Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemExtent: 30,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                        title: Text(state.addresses[index].id
                                            .toString()));
                                  },
                                  itemCount: state.addresses.length),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                      sized20,
                      Text(
                        'Получатель',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                                errorText: 'Неправильный электронной почты'),
                          ],
                        ),
                      ),
                      sized40,
                      Text(
                        'Переходя к оплате, вы принимаете условия доставки и подтверждаете достоверность ваших данных.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
                                  const EdgeInsets.symmetric(horizontal: 10),
                                  2);
                              return;
                            }
                            if (phoneController.text.length < 10) {
                              ApplicationSnackBar.showErrorSnackBar(
                                  context,
                                  'Пожалуйста, введите корректный номер мобильного телефона',
                                  0.9,
                                  const EdgeInsets.symmetric(horizontal: 10),
                                  2);
                              return;
                            }
                            if (_formKey.currentState!.validate() &&
                                phoneController.text.length >= 10) {
                              final (OrderModel?, String?) order =
                                  await OrderRepo.placeOrder(
                                product: widget.product!,
                                address: selectedAddress ?? 0,
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
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                    const EdgeInsets.symmetric(horizontal: 10),
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
  }
}
