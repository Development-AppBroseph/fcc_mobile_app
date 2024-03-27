import 'dart:async';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/auth/data/models/fcm_token.dart';
import 'package:fcc_app_front/features/auth/presentation/bloc/bloc/server_bloc.dart';
import 'package:fcc_app_front/features/chat/data/repositories/chat_repo_impl.dart';
import 'package:fcc_app_front/features/chat/di/di.dart';
import 'package:fcc_app_front/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:fcc_app_front/features/menu/presentation/bloc/order_bloc.dart';
import 'package:fcc_app_front/firebase_options.dart';
import 'package:fcc_app_front/shared/config/base/observer.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //       options: FirebaseOptions(
  //     apiKey: "AIzaSyDuZO...",
  //     authDomain: "fcc-mobile-app.firebaseapp.com",
  //     projectId: "fcc-mobile-app",
  //     storageBucket: "fcc-mobile-app.appspot.com",
  //     messagingSenderId: "367644519695",
  //     appId: "1:367644519695:web:a048cc4d451c116316e27a",
  //     measurementId: "G-HWRH4WVGSO",
  //   ));
  // } else {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Hive.initFlutter();
    await _initHive();

    // NotificationApi.init();

    // FirebaseNotificationsRepo().initNotifications(() {});
    _initChatDependencies();

    Bloc.observer = AppBlocObserver();
    runApp(
      MultiBlocProvider(
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
          BlocProvider<ChatBloc>(
              create: (BuildContext context) =>
                  ChatBloc(getIt<ChatRepositoryImpl>())),
          BlocProvider<OrderBloc>(
            create: (BuildContext context) {
              return OrderBloc()..add(FetchAllAddreses());
            },
          ),
          BlocProvider<ServerBloc>(
            create: (BuildContext context) {
              return ServerBloc()..add(const CheckServerEvent());
            },
          ),
        ],
        child: const FSC(),
      ),
    );
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

void _initChatDependencies() {
  setupDependencies();
}
