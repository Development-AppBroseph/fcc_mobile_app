import 'package:fcc_app_front/export.dart';
import 'package:share_plus/share_plus.dart';

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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double boxWidth = constraints.maxWidth;

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
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
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
                                                color:
                                                    Theme.of(context).hintColor,
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
                                        color:
                                            Theme.of(context).primaryColorLight,
                                      ),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child:
                                              BlocBuilder<AuthCubit, AuthState>(
                                            builder: (BuildContext context,
                                                AuthState state) {
                                              if (state is Authenticated) {
                                                return Text(
                                                  'fcc-app.ru/invite/${state.user.invitationCode ?? ''}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w400,
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
                                                        const EdgeInsets.all(
                                                            16),
                                                        1,
                                                        false,
                                                      );
                                                    },
                                                  );
                                                },
                                                child: SvgPicture.asset(
                                                  'assets/copy.svg',
                                                  colorFilter: ColorFilter.mode(
                                                    Theme.of(context)
                                                        .canvasColor,
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
                                        effects: const <Effect<dynamic>>[
                                          ScaleEffect(),
                                        ],
                                        child:
                                            BlocBuilder<AuthCubit, AuthState>(
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
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                      ),
                                    ],
                                  )),
                                  sized40,
                                  BlocBuilder<AuthCubit, AuthState>(
                                    builder: (BuildContext context,
                                        AuthState state) {
                                      if (state is Unauthenticated) {
                                        return const SizedBox();
                                      }
                                      if (state is Authenticated) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Поделитесь с кодом :',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge
                                                  ?.copyWith(),
                                              textAlign: TextAlign.center,
                                            ),
                                            sized30,
                                            TextButton.icon(
                                                style: ButtonStyle(
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    Theme.of(context)
                                                        .primaryColorDark,
                                                  ),
                                                  overlayColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    Theme.of(context)
                                                        .primaryColorLight,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _shareTelegram(
                                                      'fcc-app.ru/invite/${state.user.invitationCode!}');
                                                },
                                                icon: SvgPicture.asset(
                                                  'assets/telegram.svg',
                                                ),
                                                label: Text(
                                                  'Телеграм',
                                                )),
                                            sized20,
                                            TextButton.icon(
                                                style: ButtonStyle(
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(Theme.of(
                                                              context)
                                                          .primaryColorDark),
                                                  overlayColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    Theme.of(context)
                                                        .primaryColorLight,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _shareWhatsUp(
                                                      'fcc-app.ru/invite/${state.user.invitationCode}');
                                                },
                                                icon: SizedBox(
                                                  height: 30.h,
                                                  width: 30.h,
                                                  child: SvgPicture.asset(
                                                      'assets/icons8-whatsapp.svg'),
                                                ),
                                                label: const Text(
                                                  'Ватсап',
                                                )),
                                            sized20,
                                            TextButton.icon(
                                                style: ButtonStyle(
                                                  foregroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    Theme.of(context)
                                                        .primaryColorDark,
                                                  ),
                                                  overlayColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    Theme.of(context)
                                                        .primaryColorLight,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  _shareViber(
                                                      'fcc-app.ru/invite/${state.user.invitationCode}');
                                                },
                                                icon: SizedBox(
                                                  height: 30,
                                                  width: 30,
                                                  child: SvgPicture.asset(
                                                      'assets/viber.svg'),
                                                ),
                                                label: Text(
                                                  'Вайбер',
                                                )),
                                          ],
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
                                          color: Theme.of(context)
                                              .primaryColorDark,
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
      },
    );
  }

  Future<void> _shareTelegram(String text) async {
    final Uri uri = Uri.parse(
        'https://t.me/share/url?url=${text.split('/').last}&text=$text');
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }
}

Future<void> _shareWhatsUp(String text) async {
  final Uri uri = Uri.parse('https://wa.me/?text=$text');
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
  }
}

Future<void> _shareViber(String text) async {
  final Uri uri = Uri.parse('viber://forward?text=$text');
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
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
