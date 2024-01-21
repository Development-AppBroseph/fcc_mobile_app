import 'package:fcc_app_front/export.dart';

class UnauthenticatedInvitePage extends StatefulWidget {
  const UnauthenticatedInvitePage({
    Key? key,
  }) : super(key: key);
  @override
  State<UnauthenticatedInvitePage> createState() => _UnauthenticatedInvitePageState();
}

class _UnauthenticatedInvitePageState extends State<UnauthenticatedInvitePage> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 65.w,
            ),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 80.h,
                  ),
                  Text(
                    'Введите имя пользователя, который вас пригласил',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  sized30,
                  Text(
                    'Вы можете найти его имя в начале сообщения, которое вам отправил пользователь ',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: primaryColorDark,
                        ),
                  ),
                  sized10,
                  RichText(
                    text: TextSpan(
                      text: 'Если не помните или не знаете, кто пригласил вас, введите имя пользователя ',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: primaryColorDark,
                          ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '@yaroslav',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: textColor,
                              ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              controller.text = 'yaroslav';
                            },
                        ),
                      ],
                    ),
                  ),
                  sized20,
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
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontFamily: 'Rubik',
                            fontWeight: FontWeight.w400,
                            fontSize: 17,
                            color: Theme.of(context).hintColor,
                          ),
                      inputFormatters: <TextInputFormatter>[
                        LowerCaseTextFormatter(),
                      ],
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                        prefixIconConstraints: const BoxConstraints(
                          maxHeight: 40,
                        ),
                        prefixIcon: Text(
                          '@',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontFamily: 'Rubik',
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                color: Theme.of(context).hintColor,
                              ),
                        ),
                      ),
                    ),
                  ),
                  sized20,
                  CstmBtn(
                    onTap: () async {
                      if (controller.text == '') {
                        ErrorSnackBar.showErrorSnackBar(
                          context,
                          'Имя пользователя не может быть пустым',
                          0.9,
                          const EdgeInsets.symmetric(horizontal: 15),
                          3,
                        );
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        Hive.box(HiveStrings.userBox).put(
                          HiveStrings.invite,
                          controller.text,
                        );
                        context.goNamed(
                          RoutesNames.introCatalog,
                        );
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
                  CstmBtn(
                    onTap: () {
                      context.pushNamed(
                        RoutesNames.forgot,
                      );
                    },
                    height: 30,
                    text: 'Я не помню',
                    color: Colors.transparent,
                    textColor: Theme.of(context).canvasColor,
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
