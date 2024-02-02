import 'dart:developer';

import 'package:fcc_app_front/export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(
    HiveStrings.userBox,
  ).then((Box value) => log(value.get(HiveStrings.token) ?? ''));
  await Firebase.initializeApp();
  NotificationApi.init();
  runApp(
    MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit()..init(),
        ),
        BlocProvider<SelectedMembershipCubit>(
          create: (BuildContext context) => SelectedMembershipCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Future<Response> res = BaseHttpClient.getBody('api/v1/users/my-current-membership/');

    res.then((Response value) => log('Here is answer${value.body}'));
    return BlocListener<AuthCubit, AuthState>(
      listener: (BuildContext context, AuthState state) {
        router.refresh();
      },
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'FSC',
            theme: lightTheme,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
