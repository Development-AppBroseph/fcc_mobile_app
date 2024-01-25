import 'package:fcc_app_front/export.dart';

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({super.key});

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  final ConfettiController confettiController = ConfettiController();

  @override
  void initState() {
    super.initState();
    confettiController.play();
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 35.w,
            vertical: 20.h,
          ),
          child: Column(
            children: <Widget>[
              const CustomBackButton(),
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
                      'Доставка оформлена',
                      style: Theme.of(context).textTheme.titleMedium,
                    ).animate().fadeIn(duration: 1000.ms),
                    Text(
                      'Подробности можете посмотреть на экране «Доставка»',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ).animate().flip(duration: 1000.ms),
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