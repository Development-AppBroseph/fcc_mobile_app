import 'package:fcc_app_front/export.dart';

class PaymentCongratulationPage extends StatefulWidget {
  final String membership;
  final bool goMenu;

  const PaymentCongratulationPage({
    required this.membership,
    required this.goMenu,
    super.key,
  });

  @override
  State<PaymentCongratulationPage> createState() =>
      _PaymentCongratulationPageState();
}

class _PaymentCongratulationPageState extends State<PaymentCongratulationPage> {
  @override
  void initState() {
    super.initState();

    goToMenu();
  }

  String extra(String membership) {
    if (membership == 'Стандарт') {
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
    Future.delayed(const Duration(seconds: 3), () {
      membershipNames[
              MembershipType.values.firstWhereOrNull((MembershipType element) {
                    return element.name == widget.membership;
                  }) ??
                  MembershipType.standard]
          ?.toUpperCase();

      context.go(
        Routes.menu,
      );
    });
  }

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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Вы успешно подключили  тариф “${widget.membership}”',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(duration: 1000.ms),
                        sized30,
                        CstmBtn(
                          width: double.infinity,
                          onTap: () {
                            if (widget.goMenu) {
                              context.goNamed(
                                RoutesNames.menu,
                              );
                            } else {
                              context.pop();
                            }
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
