import 'package:fcc_app_front/export.dart';

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({super.key});

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  void goOrder() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      context.read<OrderCubit>().load();
      context.go(Routes.menu);
    });
  }

  @override
  void initState() {
    super.initState();
    goOrder();
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
      },
    );
  }
}
