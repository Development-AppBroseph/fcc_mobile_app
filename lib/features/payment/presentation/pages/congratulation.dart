import 'package:confetti/confetti.dart';
import 'package:fcc_app_front/shared/config/routes.dart';
import 'package:fcc_app_front/shared/constants/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/buttons/cstm_btn.dart';
import '../../../catalog/data/datasources/catalog.dart';

class PaymentCongratulationPage extends StatefulWidget {
  const PaymentCongratulationPage({
    Key? key,
    required this.membership,
    required this.goMenu,
  }) : super(key: key);
  final String membership;
  final bool goMenu;
  @override
  State<PaymentCongratulationPage> createState() => _PaymentCongratulationPageState();
}

class _PaymentCongratulationPageState extends State<PaymentCongratulationPage> {
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
    final membershipName = membershipNames[MembershipType.values
                    .firstWhereOrNull((element) => element.name == widget.membership) ??
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
            children: [
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
                  children: [
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
                      text: "Перейти в каталог",
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
