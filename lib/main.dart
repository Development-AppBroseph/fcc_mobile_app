import 'dart:developer';

import 'package:fcc_app_front/features/menu/presentation/cubit/selected_membership_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/notifications/data/repositories/notification_api.dart';
import 'shared/config/routes.dart';
import 'shared/constants/hive.dart';
import 'shared/constants/themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(
    HiveStrings.userBox,
  ).then((value) => log(value.get(HiveStrings.token) ?? ''));
  await Firebase.initializeApp();
  NotificationApi.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit()..init(),
        ),
        BlocProvider(
          create: (context) => SelectedMembershipCubit(),
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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        router.refresh();
      },
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'FSC',
          theme: lightTheme,
          routerConfig: router,
        ),
      ),
    );
  }
}
