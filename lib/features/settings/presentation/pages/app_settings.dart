// ignore_for_file: deprecated_member_use

import 'package:fcc_app_front/export.dart';

class AppSettingsPage extends StatelessWidget {
  const AppSettingsPage({super.key});

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
                      //   final fcmToken = Hive.box(HiveStrings.fcmToken).values.last;
                      // await context
                      //     .read<AuthCubit>()
                      //     .deleteFcmToken(fcmToken.toString());
                      context.read<AuthCubit>().logOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const UnauthenticatedInvitePage()),
                          (route) => false);
                      // if (context.read<SelectedMembershipCubit>().state ==
                      //     null) {
                      //   context.read<SelectedMembershipCubit>().change(
                      //         MembershipType.standard,
                      //       );
                      // }
                    },
                    iconPath: 'assets/logout.svg',
                  ),
                  sized20,
                  FillBtn(
                    text: 'Удалить учетную запись',
                    textColor: Colors.red,
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
      },
    );
  }
}
