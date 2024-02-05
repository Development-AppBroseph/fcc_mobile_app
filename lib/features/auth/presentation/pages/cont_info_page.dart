import 'package:fcc_app_front/export.dart';

class ContInfoPage extends StatefulWidget {
  final String phone;

  const ContInfoPage({
    required this.phone,
    Key? key,
  }) : super(key: key);
  @override
  State<ContInfoPage> createState() => _ContInfoPageState();
}

class _ContInfoPageState extends State<ContInfoPage> {
  bool aggreedChecked = true;
  bool oldEnoughChecked = true;
  bool isSurnameValid = false;
  TextEditingController surname = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController birthDay = TextEditingController();
  TextEditingController patronymic = TextEditingController();
  bool isLoading = false;

  bool validateAndSubmit() {
    if (!aggreedChecked) {
      ApplicationSnackBar.showErrorSnackBar(
          context,
          'Пожалуйста, примите Условия использования и Политику конфиденциальности',
          0.9,
          const EdgeInsets.symmetric(horizontal: 10),
          1);
      return false;
    }
    if (!oldEnoughChecked) {
      ApplicationSnackBar.showErrorSnackBar(context, 'Вы недостаточно взрослый, чтобы использовать это приложение', 0.9,
          const EdgeInsets.symmetric(horizontal: 10), 1);
      return false;
    }
    if (surname.text.isEmpty) {
      ApplicationSnackBar.showErrorSnackBar(
          context, 'Пожалуйста, введите фамилию', 0.9, const EdgeInsets.symmetric(horizontal: 10), 1);
      return false;
    }
    try {
      final DateTime date = DateFormat('dd-MM-yyyy').parseStrict(
        maskFormatter.getMaskedText(),
      );
      if (!(DateTime.now().compareTo(date) == 1)) {
        ApplicationSnackBar.showErrorSnackBar(
          context,
          'Дата вашего рождения не может быть этой датой',
          1,
          const EdgeInsets.symmetric(horizontal: 10),
          3,
        );
        return false;
      }
      if ((DateTime.now().compareTo(date) == 1) &&
          DateTime.now().isBefore(
            DateTime(
              date.year + 18,
              date.month,
              date.day,
            ),
          )) {
        ApplicationSnackBar.showErrorSnackBar(
          context,
          'Вам меньше 18 лет',
          1,
          const EdgeInsets.symmetric(horizontal: 10),
          3,
        );
        return false;
      }
    } catch (e) {
      ApplicationSnackBar.showErrorSnackBar(
        context,
        'Пожалуйста, введите действительную дату',
        1,
        const EdgeInsets.symmetric(horizontal: 10),
        3,
      );
      return false;
    }
    return true;
  }

  final MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    initialText: '',
    mask: '##-##-####',
    filter: <String, RegExp>{
      '#': RegExp(r'[0-9]'),
    },
  );

  final FilteringTextInputFormatter russianFormatter = FilteringTextInputFormatter.allow(
    RegExp(
      '[А-Яа-яЁё]',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              left: 35.w,
              right: 35.w,
              top: 20.h,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  if (context.canPop()) const CustomBackButton(),
                  sized30,
                  Text(
                    'Заполните контактную информацию',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  sized20,
                  RounField(
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).primaryColorDark,
                        ),
                    controller: surname,
                    hintText: 'Введите фамилию',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w400,
                        ),
                    textInputAction: TextInputAction.next,
                    inputFormatter: <TextInputFormatter>[
                      russianFormatter,
                    ],
                  ),
                  sized10,
                  RounField(
                    controller: name,
                    hintText: 'Введите имя',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w400,
                        ),
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).primaryColorDark,
                        ),
                    textInputAction: TextInputAction.next,
                    inputFormatter: <TextInputFormatter>[
                      russianFormatter,
                    ],
                  ),
                  sized10,
                  RounField(
                    controller: patronymic,
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).primaryColorDark,
                        ),
                    hintText: 'Введите отчество',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w400,
                        ),
                    textInputAction: TextInputAction.next,
                    inputFormatter: <TextInputFormatter>[
                      russianFormatter,
                    ],
                  ),
                  sized10,
                  Container(
                    padding: const EdgeInsets.all(
                      15,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    child: TextFormField(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).primaryColorDark,
                          ),
                      controller: userName,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        prefixIconConstraints: const BoxConstraints(
                          maxHeight: 40,
                        ),
                        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context).hintColor,
                              fontWeight: FontWeight.w400,
                            ),
                        hintText: ' Имя пользователя',
                        prefixIcon: Text(
                          '@',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).primaryColorDark,
                              ),
                        ),
                      ),
                      inputFormatters: <TextInputFormatter>[
                        LowerCaseTextFormatter(),
                      ],
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  sized10,
                  RounField(
                    controller: birthDay,
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).primaryColorDark,
                        ),
                    textInputType: TextInputType.number,
                    inputFormatter: <TextInputFormatter>[
                      maskFormatter,
                    ],
                    hintText: 'Дата рождения (дд-мм-гггг)',
                    hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w400,
                        ),
                    textInputAction: TextInputAction.next,
                  ),
                  sized10,
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: aggreedChecked,
                        activeColor: Theme.of(context).canvasColor,
                        onChanged: (bool? newBool) {
                          if (newBool != null) {
                            setState(
                              () {
                                aggreedChecked = newBool;
                              },
                            );
                          }
                        },
                      ),
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'Я принимаю ',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              TextSpan(
                                text: 'Условия пользования ',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: textColor,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    context.pushNamed(
                                      RoutesNames.fscData,
                                      extra: MapEntry(
                                        'Условия пользования',
                                        await ContentCubit.getData(
                                          ContentTypeEnum.termsAndConditions,
                                        ),
                                      ),
                                    );
                                  },
                              ),
                              TextSpan(
                                text: 'и ',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                              TextSpan(
                                text: 'Политику конфиденциальности ',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: textColor,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    context.pushNamed(
                                      RoutesNames.fscData,
                                      extra: MapEntry(
                                        'Политику конфиденциальности',
                                        await ContentCubit.getData(
                                          ContentTypeEnum.privacyPolicy,
                                        ),
                                      ),
                                    );
                                  },
                              ),
                              TextSpan(
                                text: 'перед использованием продукта',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  sized10,
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: oldEnoughChecked,
                        activeColor: Theme.of(context).canvasColor,
                        onChanged: (bool? newBool) {
                          if (newBool != null) {
                            setState(
                              () {
                                oldEnoughChecked = newBool;
                              },
                            );
                          }
                        },
                      ),
                      Expanded(
                        child: Text(
                          'Я подтверждаю что мне есть 18 лет',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      )
                    ],
                  ),
                  sized20,
                  CstmBtn(
                    width: double.infinity,
                    onTap: () async {
                      if (validateAndSubmit() &&
                          oldEnoughChecked &&
                          aggreedChecked &&
                          maskFormatter.isFill() &&
                          !isLoading) {
                        setState(() {
                          isLoading = true;
                        });
                        final bool isSuccess = await context.read<AuthCubit>().verifyIdentity(
                              name.text,
                              surname.text,
                              patronymic.text,
                              userName.text,
                              maskFormatter.getMaskedText(),
                              context,
                            );
                        setState(() {
                          isLoading = false;
                        });
                        if (isSuccess) {
                          FirebaseNotificationsRepo().sendFcm();
                          if (context.mounted) {
                            context.goNamed(
                              RoutesNames.catalog,
                              extra: widget.phone,
                            );
                          }
                        }
                      }
                      setState(() {
                        isLoading = false;
                      });
                    },
                    text: 'Отправить на проверку',
                    child: isLoading
                        ? Row(
                            children: <Widget>[
                              Text(
                                'Продолжить',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: primaryColorDark,
                                  strokeWidth: 3,
                                ),
                              ),
                            ],
                          )
                        : null,
                  ),
                  sized20,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
