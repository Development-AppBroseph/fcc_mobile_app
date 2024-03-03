import 'package:fcc_app_front/export.dart';
import 'package:lottie/lottie.dart';

class ServerStatusScreen extends StatelessWidget {
  const ServerStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (BuildContext context, AuthState state) {
        if (state is Unauthenticated) {
          return;
        } else if (state is Authenticated) {
          context.go(Routes.menu);
        } else {
          context.go(Routes.unauthenticatedInvite);
        }
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                LottieBuilder.asset('assets/animation/server_error.json'),
                const Text(
                  'В связи с большим количеством запросов работа приложения временно приостановлена.Наши специалисты уже работают на этим',
                ),
                sized40,
                CstmBtn(
                    text: 'Обновить',
                    onTap: () {
                      context.read<AuthCubit>().checkServerState();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
