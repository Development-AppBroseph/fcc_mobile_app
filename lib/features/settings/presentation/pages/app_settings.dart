// ignore_for_file: deprecated_member_use

import 'package:fcc_app_front/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fcc_app_front/features/catalog/data/datasources/catalog.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/selected_membership_cubit.dart';
import 'package:fcc_app_front/features/settings/data/utils/confirm_delete_sheet.dart';
import 'package:fcc_app_front/shared/config/routes.dart';
import 'package:fcc_app_front/shared/constants/widgets/custom_back.dart';
import 'package:fcc_app_front/shared/constants/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/buttons/filled_btn.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 25.h,
            horizontal: 35.w,
          ),
          child: Column(
            children: [
              CustomBackButton(),
              sized20,
              Text(
                "Настройки",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              sized40,
              FillBtn(
                text: "Изменить номер",
                onTap: () {
                  context.goNamed(
                    RoutesNames.changeNumber,
                  );
                },
                iconPath: "assets/call.svg",
              ),
              sized20,
              FillBtn(
                text: "Посмотреть свои данные",
                onTap: () {
                  context.goNamed(
                    RoutesNames.editProfile,
                  );
                },
                iconPath: "assets/edit.svg",
              ),
              sized20,
              FillBtn(
                text: "Выйти",
                onTap: () {
                  context.read<AuthCubit>().logOut();
                  if (context.read<SelectedMembershipCubit>().state == null) {
                    context.read<SelectedMembershipCubit>().change(
                          MembershipType.standard,
                        );
                  }
                  context.goNamed(
                    RoutesNames.menu,
                  );
                },
                iconPath: "assets/logout.svg",
              ),
              sized20,
              FillBtn(
                text: "Удалить учетную запись",
                textColor: Theme.of(context).errorColor,
                onTap: () {
                  showConfirmDeleteDialog(context);
                },
                iconPath: "assets/delete.svg",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
