// ignore_for_file: deprecated_member_use

import 'package:fcc_app_front/export.dart';

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
            children: <Widget>[
              CustomBackButton(),
              sized20,
              Text(
                'Настройки',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              sized40,
              FillBtn(
                text: 'Изменить номер',
                onTap: () {
                  context.goNamed(
                    RoutesNames.changeNumber,
                  );
                },
                iconPath: 'assets/call.svg',
              ),
              sized20,
              FillBtn(
                text: 'Посмотреть свои данные',
                onTap: () {
                  context.goNamed(
                    RoutesNames.editProfile,
                  );
                },
                iconPath: 'assets/edit.svg',
              ),
              sized20,
              FillBtn(
                text: 'Выйти',
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
                iconPath: 'assets/logout.svg',
              ),
              sized20,
              FillBtn(
                text: 'Удалить учетную запись',
                textColor: Theme.of(context).errorColor,
                onTap: () {
                  showConfirmDeleteDialog(context);
                },
                iconPath: 'assets/delete.svg',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
