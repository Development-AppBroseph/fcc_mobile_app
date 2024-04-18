import 'package:fcc_app_front/export.dart';

class OrderConfirmationPage extends StatefulWidget {
  const OrderConfirmationPage({super.key});

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
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
              CustomBackButton(
                pop: false,
                path: RoutesNames.menu,
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
