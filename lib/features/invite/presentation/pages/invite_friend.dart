import 'package:fcc_app_front/features/fcc_settings/data/utils/launch_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import 'package:fcc_app_front/features/invite/data/models/invitation.dart';
import 'package:fcc_app_front/features/invite/presentation/cubit/invitation_cubit.dart';
import 'package:fcc_app_front/shared/config/routes.dart';
import 'package:fcc_app_front/shared/constants/widgets/error_snackbar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_extend/share_extend.dart';

import '../../../../shared/constants/colors/color.dart';
import '../../../../shared/constants/widgets/custom_back.dart';
import '../../../../shared/constants/widgets/sizedbox.dart';
import '../../../../shared/widgets/buttons/cstm_btn.dart';
import '../../../auth/presentation/cubit/auth_cubit.dart';

class InviteFrPage extends StatefulWidget {
  const InviteFrPage({super.key, this.showBackButton = true});
  final bool showBackButton;

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
            builder: (context, auth) {
              return auth is Authenticated
                  ? SingleChildScrollView(
                      child: BlocBuilder<InvitationCubit, InvitationModel?>(
                        builder: (context, state) {
                          if (state == null) return Container();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sized30,
                              if (widget.showBackButton) CustomBackButton(),
                              Center(
                                child: Text(
                                  "Пригласить друга",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontSize: 23),
                                ),
                              ),
                              sized10,
                              Text(
                                "Ваше имя пользователя",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 12,
                                      color: Theme.of(context).hintColor,
                                    ),
                              ),
                              sized10,
                              BlocBuilder<AuthCubit, AuthState>(
                                builder: (context, state) {
                                  return Container(
                                    height: 50,
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
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
                                      children: [
                                        Text(
                                          state is Authenticated
                                              ? '@${state.user.userName}'
                                              : 'user',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              sized10,
                              Center(
                                child: Column(
                                  children: [
                                    Animate(
                                      effects: const [
                                        ScaleEffect(),
                                      ],
                                      child: QrImageView(
                                        data: 'https://fcc.i7.kg/',
                                        version: QrVersions.auto,
                                        size: 200.0,
                                      ),
                                    ),
                                    Text(
                                      "Покажите QR-код друзьям",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontSize: 14,
                                            color: Theme.of(context).hintColor,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                              sized20,
                              Text(
                                "Не нужно платить !",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              sized10,
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          "При помощи этой ссылки вы можете получать 10% скидку на свой ежемесячный набор продуктов",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            fontSize: 13,
                                            color: Theme.of(context).hintColor,
                                          ),
                                    ),
                                    TextSpan(
                                      text: " за каждого друга!",
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
                              sized10,
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
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'https://fcc.i7.kg/',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await Clipboard.setData(
                                          const ClipboardData(
                                            text: 'https://fcc.i7.kg/',
                                          ),
                                        ).then(
                                          (_) {
                                            showErrorSnackbar(
                                              context,
                                              'Cкопирован в буфер обмена',
                                            );
                                          },
                                        );
                                      },
                                      child: SvgPicture.asset(
                                        "assets/copy.svg",
                                        colorFilter: ColorFilter.mode(
                                          Theme.of(context).canvasColor,
                                          BlendMode.srcIn,
                                        ),
                                        height: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              sized10,
                              CstmBtn(
                                height: 50,
                                onTap: () {
                                  ShareExtend.share(
                                    'https://fcc.i7.kg/',
                                    "text",
                                  );
                                },
                                text: "Поделиться ссылкой",
                                alignment: MainAxisAlignment.center,
                                iconPath: "assets/send.svg",
                                textColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                color: Theme.of(context).canvasColor,
                              ),
                              sized10,
                            ],
                          );
                        },
                      ),
                    )
                  : Column(
                      children: [
                        sized20,
                        CustomBackButton(
                          path: RoutesNames.introCatalog,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                text: "Войти",
                                alignment: MainAxisAlignment.center,
                                textColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                color: Theme.of(context).canvasColor,
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
  const StoreButtons({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (title == "Play Store") {
            launchStore(
              url:
                  "https://play.google.com/store/apps/details?id=com.ashvaiberov.fscu",
            );
          } else {
            launchStore(
              url: "https://apps.apple.com/app/",
            );
          }
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).canvasColor,
            boxShadow: [
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
            children: [
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
