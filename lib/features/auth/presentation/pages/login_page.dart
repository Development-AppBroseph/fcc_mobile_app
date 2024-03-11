import 'package:fcc_app_front/export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  final MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    initialText: '+7 ',
    mask: '+7 ###-###-##-##',
    filter: <String, RegExp>{
      '#': RegExp(r'[0-9]'),
    },
  );
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    print('weorked login init');
    context.read<AuthCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 40.w,
            ),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 40.h,
                  ),
                  CustomBackButton(
                    path: RoutesNames.menu,
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  Text(
                    'Введите',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'номер телефона',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Чтобы войти или стать',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                  ),
                  Text(
                    'членом клуба ФКК',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextField(
                        textInputAction: TextInputAction.done,
                        inputFormatters: <TextInputFormatter>[
                          maskFormatter,
                        ],
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                        decoration: InputDecoration(
                          hintText: '+7 (000) 000-00-00',
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
                        controller: phoneController,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CstmBtn(
                    width: double.infinity,
                    onTap: () async {
                      if (!maskFormatter.isFill()) {
                        ApplicationSnackBar.showErrorSnackBar(
                          context,
                          'Неверный формат номера телефона',
                          0.9,
                          const EdgeInsets.symmetric(horizontal: 15),
                          3,
                        );
                      } else if (maskFormatter.isFill() && !isLoading) {
                        setState(() {
                          isLoading = true;
                        });
                        final (bool, bool) isSuccess =
                            await context.read<AuthCubit>().createUserSendCode(
                                  maskFormatter
                                      .getMaskedText()
                                      .replaceAll(' ', '')
                                      .replaceAll('-', ''),
                                );
                        if (isSuccess.$1 && context.mounted) {
                          showCupertinoModalBottomSheet(
                            context: context,
                            expand: true,
                            builder: (BuildContext context) {
                              return CstmBtmSheet(
                                isRegistration: isSuccess.$2,
                                phone: maskFormatter
                                    .getMaskedText()
                                    .replaceAll(' ', '')
                                    .replaceAll('-', ''),
                              );
                            },
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    text: 'Продолжить',
                    child: isLoading
                        ? Row(
                            children: <Widget>[
                              Text(
                                'Продолжить',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(),
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
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
