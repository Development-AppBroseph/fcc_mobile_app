import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/auth/presentation/bloc/bloc/server_bloc.dart';
import 'package:lottie/lottie.dart';

class ServerErrorPage extends StatelessWidget {
  const ServerErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ServerBloc, ServerState>(
      listener: (BuildContext context, ServerState state) {
        if (state is ServerOnline) {
          context.go(Routes.agreement);
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Lottie.asset('assets/server_error.json'),
              const Text(
                'В связи с большим количеством запросов работа приложения временно приостановлена. Наши специалисты уже работают на этим',
                textAlign: TextAlign.center,
              ),
              BlocListener<ServerBloc, ServerState>(
                listener: (BuildContext context, ServerState state) {
                  if (state is ServerOnline) {
                    context.go(Routes.agreement);
                  }
                },
                child: CstmBtn(
                    text: 'Обновить',
                    onTap: () {
                      context.read<ServerBloc>().add(const CheckServerEvent());
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
