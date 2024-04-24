import 'package:fcc_app_front/export.dart';

class PaymentCongratulationPage extends StatefulWidget {
  final String membership;
  final bool goMenu;

  const PaymentCongratulationPage({
    required this.membership,
    required this.goMenu,
    Key? key,
  }) : super(key: key);

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
    final String membershipName = membershipNames[MembershipType.values
                    .firstWhereOrNull((MembershipType element) {
                  return element.name == widget.membership;
                }) ??
                MembershipType.standard]
            ?.toUpperCase() ??
        'Стандарт';
    ApplicationSnackBar.showErrorSnackBar(
        context,
        'Вы приобрели тариф $membershipName',
        1,
        const EdgeInsets.all(200),
        1,
        false);
    context.go(
      Routes.profile,
    );
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
        final double boxWidth = constraints.maxWidth;

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
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
