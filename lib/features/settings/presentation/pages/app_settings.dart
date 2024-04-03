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
              const CustomBackButton(),
              sized20,
              Text(
                'Настройки',
                style: Theme.of(context).textTheme.titleMedium,
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
                onTap: () async {
                  final fcmToken = Hive.box(HiveStrings.fcmToken).values.last;
                  await context
                      .read<AuthCubit>()
                      .deleteFcmToken(fcmToken.toString());
                  context.read<AuthCubit>().logOut();
                  if (context.read<SelectedMembershipCubit>().state == null) {
                    context.read<SelectedMembershipCubit>().change(
                          MembershipType.standard,
                        );
                  }

                  context.go(
                    Routes.login,
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
