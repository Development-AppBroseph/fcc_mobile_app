import 'package:fcc_app_front/export.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    Key? key,
    required this.error,
  }) : super(key: key);
  final String error;
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: const Text('Error Screen'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                error,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => context.goNamed(
                  RoutesNames.menu,
                ),
                child: const Text('Go to home page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
