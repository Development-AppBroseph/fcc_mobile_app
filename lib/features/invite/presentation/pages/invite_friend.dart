import 'package:fcc_app_front/export.dart';

class InviteFrPage extends StatefulWidget {
  final bool showBackButton;

  const InviteFrPage({
    this.showBackButton = true,
    super.key,
  });

  @override
  State<InviteFrPage> createState() => _InviteFrPageState();
}

class _InviteFrPageState extends State<InviteFrPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (BuildContext context, AuthState auth) {
              return auth is Authenticated
                  ? SingleChildScrollView(
                      child: BlocBuilder<InvitationCubit, InvitationModel?>(
                        builder:
                            (BuildContext context, InvitationModel? state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              sized30,
                              if (widget.showBackButton)
                                const CustomBackButton(),
                              Center(
                                child: Text(
                                  'Пригласить друга',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                        fontSize: 23,
                                      ),
                                ),
                              ),
                              sized20,
                              Text(
                                'Не нужно платить !',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              sized40,
                              RichText(
                                text: TextSpan(
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text:
                                          'При помощи данного инвайт кода вы можете получать 10% скидку на свой ежемесячный набор продуктов ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontSize: 13,
                                            color: Theme.of(context).hintColor,
                                          ),
                                    ),
                                    TextSpan(
                                      text: ' за каждого друга!',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontSize: 13,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              sized40,
                              Container(
                                height: 50,
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Theme.of(context).primaryColorLight,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: BlocBuilder<AuthCubit, AuthState>(
                                        builder: (BuildContext context,
                                            AuthState state) {
                                          if (state is Authenticated) {
                                            return Text(
                                              'fcc-app.ru/invite/${state.user.invitationCode ?? ''}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .hintColor,
                                                  ),
                                            );
                                          }
                                          if (state is Unauthenticated) {
                                            return const Text(
                                              'Не авторизован',
                                            );
                                          }
                                          return const SizedBox.shrink();
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    BlocBuilder<AuthCubit, AuthState>(
                                      builder: (BuildContext context,
                                          AuthState state) {
                                        if (state is Unauthenticated) {
                                          return const SizedBox();
                                        }
                                        if (state is Authenticated) {
                                          return GestureDetector(
                                            onTap: () async {
                                              await Clipboard.setData(
                                                ClipboardData(
                                                  text:
                                                      'fcc-app.ru/invite/${state.user.invitationCode ?? ''}',
                                                ),
                                              ).then(
                                                (_) {
                                                  ApplicationSnackBar
                                                      .showErrorSnackBar(
                                                    context,
                                                    'Cкопирован в буфер обмена',
                                                    1,
                                                    const EdgeInsets.all(16),
                                                    1,
                                                    false,
                                                  );
                                                },
                                              );
                                            },
                                            child: SvgPicture.asset(
                                              'assets/copy.svg',
                                              colorFilter: ColorFilter.mode(
                                                Theme.of(context).canvasColor,
                                                BlendMode.srcIn,
                                              ),
                                              height: 18,
                                            ),
                                          );
                                        }
                                        return const SizedBox();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              sized40,
                              Center(
                                  child: Column(
                                children: <Widget>[
                                  Animate(
                                    effects: const <Effect>[
                                      ScaleEffect(),
                                    ],
                                    child: BlocBuilder<AuthCubit, AuthState>(
                                      builder: (
                                        BuildContext context,
                                        AuthState state,
                                      ) {
                                        if (state is Authenticated) {
                                          return QrImageView(
                                            data:
                                                // state.user.invitationCode ?? '',
                                                'fcc-app.ru/invite/${state.user.invitationCode}',
                                            version: QrVersions.auto,
                                            size: 200.0,
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      },
                                    ),
                                  ),
                                  Text(
                                    'Покажите QR-код друзьям',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontSize: 14,
                                          color: Theme.of(context).hintColor,
                                        ),
                                  ),
                                ],
                              )),
                              sized40,
                              BlocBuilder<AuthCubit, AuthState>(
                                builder:
                                    (BuildContext context, AuthState state) {
                                  if (state is Unauthenticated) {
                                    return const SizedBox();
                                  }
                                  if (state is Authenticated) {
                                    return CstmBtn(
                                      height: 50,
                                      onTap: () {
                                        ShareExtend.share(
                                          state.user.invitationCode ?? '',
                                          'text',
                                        );
                                      },
                                      text: 'Поделиться  кодом',
                                      alignment: MainAxisAlignment.center,
                                      iconPath: 'assets/send.svg',
                                      textColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      color: Theme.of(context).canvasColor,
                                    );
                                  }
                                  return const SizedBox();
                                },
                              ),
                              sized10,
                            ],
                          );
                        },
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        sized20,
                        CustomBackButton(
                          path: RoutesNames.introCatalog,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
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
                                text: 'Войти',
                                alignment: MainAxisAlignment.center,
                                textColor: Colors.black,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}

class StoreButtons extends StatelessWidget {
  final String title;
  final String icon;

  const StoreButtons({
    required this.title,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (title == 'Play Store') {
            launchStore(
              url:
                  'https://play.google.com/store/apps/details?id=com.ashvaiberov.fscu',
            );
          } else {
            launchStore(
              url: 'https://apps.apple.com/app/',
            );
          }
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).canvasColor,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: primaryColor.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                icon,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
