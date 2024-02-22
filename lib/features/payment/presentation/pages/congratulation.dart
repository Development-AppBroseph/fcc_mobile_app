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
  final ConfettiController confettiController = ConfettiController();

  @override
  void initState() {
    super.initState();

    confettiController.play();
    goToMenu();
  }

  void goToMenu() {
    Future<void>.delayed(const Duration(seconds: 3)).then((value) {
      context.read<AuthCubit>().init();
      context.pushReplacement(RoutesNames.menu);
    });
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
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
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 35.w,
            vertical: 20.h,
          ),
          child: Column(
            children: <Widget>[
              ConfettiWidget(
                confettiController: confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                blastDirection: -1.5,
                particleDrag: 0.01,
                emissionFrequency: 0.02,
                numberOfParticles: 50,
                gravity: 0.05,
                shouldLoop: false,
              ),
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
  }
}
