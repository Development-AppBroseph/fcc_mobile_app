import 'package:fcc_app_front/export.dart';

class NotSignedPage extends StatelessWidget {
  const NotSignedPage({super.key});

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
                      bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Вы не авторизованы',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColorDark,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  sized20,
                  Text(
                    'Сначала вам необходимо пройти аутентификацию, чтобы увидеть ссылку-приглашение.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
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
