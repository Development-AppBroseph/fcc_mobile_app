import 'dart:async';
import 'dart:developer';

import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/chat/data/repositories/chat_repo_impl.dart';
import 'package:fcc_app_front/features/chat/di/di.dart';
import 'package:fcc_app_front/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:fcc_app_front/shared/config/base/observer.dart';

void main() {
  runZonedGuarded(() async {
    await Hive.initFlutter();
    await _initHive();

    _initChatDependencies();
    await Firebase.initializeApp();
    //  NotificationApi.init();
    WidgetsFlutterBinding.ensureInitialized();
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
          BlocProvider<AuthCubit>(
            create: (BuildContext context) => AuthCubit()..init(),
          ),
          BlocProvider<SelectedMembershipCubit>(
            create: (BuildContext context) => SelectedMembershipCubit(),
          ),
          BlocProvider<CatalogCubit>(
            create: (BuildContext context) => CatalogCubit()..load(),
          ),
          BlocProvider<SearchCubit>(
            create: (BuildContext context) => SearchCubit(),
          ),
          BlocProvider<ProductCubit>(
            create: (BuildContext context) => ProductCubit()..load(),
          ),
          BlocProvider<SelectedProductsCubit>(
            create: (BuildContext context) => SelectedProductsCubit(),
          ),
          BlocProvider<ChatBloc>(
            create: (BuildContext context) => ChatBloc(getIt<ChatRepositoryImpl>())
              ..add(
                FecthAllChatEvent(),
              ),
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

  await Hive.openBox<MessageModel>(HiveStrings.message);
  // Hive.registerAdapter(MessageModelAdapter());
}

void _initChatDependencies() {
  setupDependencies();
}
