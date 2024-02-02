import 'package:fcc_app_front/export.dart';

class AgreementScreen extends StatelessWidget {
  const AgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
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
                  CstmBtn(
                    text: 'Да',
                    onTap: () {
                      context.pushReplacementNamed(RoutesNames.unauthenticatedInvite);
                    },
                  ),
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
                        desc: 'К сожалению,доступ разрешен только пользователям старше 18 лет',
                        buttonsTextStyle: const TextStyle(color: Colors.black),
                        showCloseIcon: true,
                      ).show();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
