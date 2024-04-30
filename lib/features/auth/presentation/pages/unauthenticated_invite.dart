import 'dart:developer';

import 'package:app_links/app_links.dart';
import 'package:fcc_app_front/export.dart';

class UnauthenticatedInvitePage extends StatefulWidget {
  const UnauthenticatedInvitePage({
    super.key,
  });
  @override
  State<UnauthenticatedInvitePage> createState() =>
      _UnauthenticatedInvitePageState();
}

class _UnauthenticatedInvitePageState extends State<UnauthenticatedInvitePage> {
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  String? _inviteCode;
  final AppLinks _appLinks = AppLinks();

  Future<void> _initUniLinks() async {
    try {
      _appLinks.allUriLinkStream.listen((Uri uri) {
        setState(() {
          _inviteCode = uri.toString().split('/').last;
          log(uri.toString());

          if (_inviteCode != null) {
            controller.text = _inviteCode ?? '';
          }
        });
      });
    } on Exception {
      log('getInitialLink error');
    }
  }

  @override
  void initState() {
    super.initState();
    _initUniLinks();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double availableWidth = constraints.maxWidth;

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: availableWidth < 600 ? 40.0 : 140.w,
                ),
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        height: 80.h,
                      ),
                      Text(
                        'Введите свой инвайт код',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      sized30,
                      Text(
                        'Если не помните свой инвайт код проверьте приглашение, полученное ранее',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: primaryColorDark,
                            ),
                      ),
                      sized10,

                      sized40,
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
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontFamily: 'Rubik',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Theme.of(context).hintColor,
                                  ),
                          controller: controller,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            prefixIconConstraints: BoxConstraints(
                              maxHeight: 40,
                            ),
                          ),
                        ),
                      ),
                      sized40,
                      CstmBtn(
                        onTap: () async {
                          if (controller.text == '') {
                            ApplicationSnackBar.showErrorSnackBar(
                              context,
                              'Инвайт код не может быть пустым',
                              0.9,
                              const EdgeInsets.symmetric(horizontal: 15),
                              3,
                            );
                          } else {
                            final bool inviteLink = await context
                                .read<AuthCubit>()
                                .checkInviteByLink(
                                  username: controller.text,
                                );

                            if (inviteLink) {
                              setState(() {
                                isLoading = true;
                              });
                              Hive.box(HiveStrings.userBox).put(
                                HiveStrings.invite,
                                controller.text,
                              );
                              if (mounted) {
                                Hive.box(HiveStrings.userBox).put(
                                  HiveStrings.invite,
                                  controller.text,
                                );

                                context.goNamed(
                                  RoutesNames.introCatalog,
                                );
                              }
                              setState(() {
                                isLoading = false;
                              });
                            } else {
                              if (mounted) {
                                ApplicationSnackBar.showErrorSnackBar(
                                  context,
                                  'Указанный инвайт код не найден,попробуйте ещё раз',
                                  0.9,
                                  const EdgeInsets.symmetric(horizontal: 15),
                                  3,
                                );
                              }
                            }
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
                      sized20,
                      // CstmBtn(
                      //   onTap: () {
                      //     context.pushNamed(
                      //       RoutesNames.forgot,
                      //     );
                      //   },
                      //   height: 30,
                      //   text: 'Я не помню',
                      //   color: Colors.transparent,
                      //   textColor: Theme.of(context).canvasColor,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
