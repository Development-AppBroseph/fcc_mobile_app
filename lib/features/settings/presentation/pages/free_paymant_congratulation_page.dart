import 'package:fcc_app_front/export.dart';

class FreePaymantCongratulationPage extends StatefulWidget {
  final String membership;

  const FreePaymantCongratulationPage({
    required this.membership,
    Key? key,
  }) : super(key: key);

  @override
  State<FreePaymantCongratulationPage> createState() =>
      _FreePaymantCongratulationPageState();
}

class _FreePaymantCongratulationPageState
    extends State<FreePaymantCongratulationPage> {
  @override
  void initState() {
    super.initState();

    goToMenu();
  }

  String extra(String membership) {
    if (membership == 'standard') {
      return '1';
    } else if (membership == 'premium') {
      return '2';
    } else if (membership == 'elite') {
      return '3';
    } else {
      return '4';
    }
  }

  void goToMenu() {
    Future<dynamic>.delayed(const Duration(seconds: 3)).then((dynamic value) {
      context.go(
        Routes.profile,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final String membershipName = membershipNames[MembershipType.values
                    .firstWhereOrNull((MembershipType element) {
                  return element.name == widget.membership;
                }) ??
                MembershipType.standard]
            ?.toUpperCase() ??
        'Стандарт';
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double boxWidth = constraints.constrainWidth();

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
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Вы успешно подключили  тариф “$membershipName"',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(duration: 1000.ms),
                        sized30,
                        CstmBtn(
                          width: double.infinity,
                          onTap: () {
                            context.go(
                              Routes.profile,
                            );
                          },
                          text: 'Перейти в каталог',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
