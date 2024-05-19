import 'dart:async';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/auth/data/models/fcm_token.dart';
import 'package:fcc_app_front/features/auth/presentation/bloc/bloc/server_bloc.dart';
import 'package:fcc_app_front/features/menu/presentation/bloc/order_bloc.dart';
import 'package:fcc_app_front/features/payment/service/payment_service.dart';
import 'package:fcc_app_front/shared/config/base/observer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  NotificationApi.pushNotification(message);
}

Future<void> main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await NotificationApi.init();

    await Hive.initFlutter();
    await _initHive();

    Bloc.observer = AppBlocObserver();
    runApp(MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider<BottomNavbarCont>(
          create: (BuildContext context) {
            return BottomNavbarCont();
          },
        ),
        BlocProvider<OrderCubit>(
          create: (_) => OrderCubit(),
        ),
        BlocProvider<MembershipCubit>(
          create: (_) => MembershipCubit()..load(),
        ),
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit()..init(),
        ),
        BlocProvider<SelectedMembershipCubit>(
          create: (BuildContext context) => SelectedMembershipCubit(),
        ),
        BlocProvider<CatalogCubit>(
          create: (BuildContext context) => CatalogCubit(),
        ),
        BlocProvider<SearchCubit>(
          create: (BuildContext context) => SearchCubit(),
        ),
        BlocProvider<ProductCubit>(
          create: (BuildContext context) => ProductCubit(),
        ),
        BlocProvider<SelectedProductsCubit>(
          create: (BuildContext context) => SelectedProductsCubit(),
        ),
        BlocProvider<OrderBloc>(
          create: (BuildContext context) {
            return OrderBloc();
          },
        ),
        BlocProvider<ServerBloc>(
          create: (BuildContext context) {
            return ServerBloc()..add(const CheckServerEvent());
          },
        ),
      ],
      child: MultiProvider(
        providers: [
          Provider<PaymentService>(create: (_) => PaymentService()),
        ],
        child: const FSC(),
      ),
    ));
  }, (Object error, StackTrace stackTrace) {
    log('Uncaught error: $error\n$stackTrace');
  });
}

class FSC extends StatelessWidget {
  const FSC({super.key});

  @override
  Widget build(BuildContext context) {
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

Future<void> _initHive() async {
  await Hive.openBox(
    HiveStrings.userBox,
  ).then((Box value) => log(
        value.get(HiveStrings.token) ?? '',
      ));
  await Hive.openBox<dynamic>(HiveStrings.isFcmSent);
  await Hive.openBox<dynamic>(HiveStrings.message);
  Hive.registerAdapter(FcmTokenAdapter());
  await Hive.openBox<dynamic>(HiveStrings.fcmToken);
}
