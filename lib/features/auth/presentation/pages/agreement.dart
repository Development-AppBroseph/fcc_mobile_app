import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/auth/presentation/bloc/bloc/server_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:uni_links/uni_links.dart';

class AgreementScreen extends StatefulWidget {
  const AgreementScreen({super.key});

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  @override
  void initState() {
    super.initState();
    initUniLinks();
    context.read<ServerBloc>().add(const CheckServerEvent());
  }

  Future<void> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialLink();

      final link = initialLink;
      if (kDebugMode) {
        print('Initial Link: $link');
      }
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocListener<ServerBloc, ServerState>(
      listener: (BuildContext context, ServerState state) {
        if (state is ServerOffline) {
          context.go(Routes.serverState);
        }
      },
      child: BlocListener<AuthCubit, AuthState>(
        listener: (BuildContext context, AuthState state) {
          if (state is ServerOffline) {
            context.go(RoutesNames.serverState);
          }

          if (state is Authenticated) {
            context.go(Routes.menu);
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(size.width < 600 ? 24.0 : 140),
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double availableWidth = constraints.maxWidth;
                  double availableHeight = constraints.maxHeight;

                  if (availableWidth < 600) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        SizedBox(
                            height: size.height / 4.h,
                            child: Image.asset(
                              Assets.avatars.appIcon.path,
                            )),
                        Column(
                          children: <Widget>[
                            const Text('Вам исполнилось 18 лет?'),
                            sized40,
                            BlocBuilder<AuthCubit, AuthState>(builder:
                                (BuildContext context, AuthState state) {
                              return CstmBtn(
                                text: 'Да',
                                onTap: () {
                                  if (state is Unauthenticated) {
                                    context.pushNamed(
                                        RoutesNames.unauthenticatedInvite);
                                  } else {
                                    context.pushNamed(RoutesNames.menu);
                                  }
                                },
                              );
                            }),
                            sized20,
                            CstmBtn(
                              color: Colors.black12,
                              text: 'Нет',
                              onTap: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  headerAnimationLoop: true,
                                  animType: AnimType.bottomSlide,
                                  title: '18+',
                                  desc:
                                      'К сожалению,доступ разрешен только пользователям старше 18 лет',
                                  buttonsTextStyle:
                                      const TextStyle(color: Colors.black),
                                  showCloseIcon: true,
                                ).show();
                              },
                            ),
                          ],
                        ),
                      ],
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 600),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                              height: size.height / 4.h,
                              child: Image.asset(
                                Assets.avatars.appIcon.path,
                              )),
                          SizedBox(
                            width: size.width / 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                const Text('Вам исполнилось 18 лет?'),
                                sized40,
                                BlocBuilder<AuthCubit, AuthState>(builder:
                                    (BuildContext context, AuthState state) {
                                  return CstmBtn(
                                    text: 'Да',
                                    onTap: () {
                                      if (state is Unauthenticated) {
                                        context.pushNamed(
                                            RoutesNames.unauthenticatedInvite);
                                      } else {
                                        context.pushNamed(RoutesNames.menu);
                                      }
                                    },
                                  );
                                }),
                                sized20,
                                CstmBtn(
                                  color: Colors.black12,
                                  text: 'Нет',
                                  onTap: () {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.error,
                                      headerAnimationLoop: true,
                                      animType: AnimType.bottomSlide,
                                      title: '18+',
                                      desc:
                                          'К сожалению,доступ разрешен только пользователям старше 18 лет',
                                      buttonsTextStyle:
                                          const TextStyle(color: Colors.black),
                                      showCloseIcon: true,
                                    ).show();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
