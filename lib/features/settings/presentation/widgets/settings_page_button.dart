import 'package:fcc_app_front/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fcc_app_front/features/chat/data/repositories/chat_repo.dart';
import 'package:fcc_app_front/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:fcc_app_front/features/settings/data/models/setting.dart';
import 'package:fcc_app_front/features/settings/presentation/cubit/discount_cubit.dart';
import 'package:fcc_app_front/shared/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/constants/widgets/sizedbox.dart';
import '../../../../shared/widgets/buttons/filled_btn.dart';
import '../../../../shared/widgets/on_tap_scale.dart';

class SettingsPageButton extends StatelessWidget {
  const SettingsPageButton({
    Key? key,
    required this.setting,
    this.isFsc = false,
  }) : super(key: key);
  final SettingModel setting;
  final bool isFsc;
  @override
  Widget build(BuildContext context) {
    if (isFsc) {
      return OnTapScaleAndFade(
        onTap: () {
          context.goNamed(
            RoutesNames.fscSettings,
          );
        },
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).hintColor.withOpacity(0.05),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          margin: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset(
                    "assets/avatars/fsk.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                "ФКК",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              sized30,
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      child: FillBtn(
        text: setting.title,
        onTap: () async {
          if (context.read<AuthCubit>().state is Unauthenticated) {
            context.goNamed(RoutesNames.notSigned);
            return;
          }
          if (setting.route == RoutesNames.chat) {
            final id = await ChatRepo.getChat();
            if (id != null && context.mounted) {
              context.pushNamed(
                setting.route,
                pathParameters: {
                  'id': id.toString(),
                },
                extra: BlocProvider.of<ChatCubit>(context)..load(),
              );
            }
          } else if (setting.route == RoutesNames.addPerson) {
            context.pushNamed(
              setting.route,
              extra: BlocProvider.of<DiscountCubit>(context),
            );
          } else if (setting.route == RoutesNames.changePlan) {
            final authState = context.read<AuthCubit>().state;
            context.pushNamed(
              setting.route,
              extra: authState is Authenticated ? authState.user.phoneNumber : '',
            );
          } else {
            context.pushNamed(
              setting.route,
            );
          }
        },
        iconPath: "assets/settings/${setting.icon}.svg",
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
