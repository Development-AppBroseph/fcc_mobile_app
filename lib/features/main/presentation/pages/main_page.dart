import 'package:fcc_app_front/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:fcc_app_front/features/fcc_settings/presentation/cubit/content_cubit.dart';
import 'package:fcc_app_front/features/invite/presentation/cubit/invitation_cubit.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/catalog_cubit.dart';
import 'package:fcc_app_front/features/menu/presentation/cubit/order_cubit.dart';
import 'package:fcc_app_front/features/notifications/data/repositories/notifications.dart';
import 'package:fcc_app_front/features/settings/presentation/cubit/discount_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../menu/presentation/cubit/product_cubit.dart';
import '../../data/datasources/bottombar_items.dart';
import '../../data/utils/bottombar_handler.dart';
import '../cubit/bottom_navbar_cont.dart';
import '../widgets/cstm_bottom_nav.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BottomNavbarCont(),
        ),
        BlocProvider(
          create: (context) => ProductCubit()
            ..load(
              isPublic: context.read<AuthCubit>().state is Unauthenticated,
            ),
        ),
        BlocProvider(
          create: (context) => ContentCubit()..load(),
        ),
        BlocProvider(
          create: (context) => OrderCubit()..load(),
        ),
        BlocProvider(
          create: (context) => ChatCubit()..load(),
        ),
        BlocProvider(
          create: (context) => CatalogCubit()
            ..load(
              isPublic: context.read<AuthCubit>().state is Unauthenticated,
            ),
        ),
        BlocProvider(
          create: (context) => InvitationCubit()..load(),
        ),
        BlocProvider(
          create: (context) => DiscountCubit()..load(),
        ),
      ],
      child: Builder(builder: (context) {
        return KeyboardDismisser(
          child: MainScaffold(
            child: child,
          ),
        );
      }),
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        await FirebaseNotificationsRepo().sendFcm();
        await FirebaseMessaging.instance.getInitialMessage();
        await FirebaseNotificationsRepo().initNotifications(
          // ignore: use_build_context_synchronously
          context.read<ChatCubit>().load(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<BottomNavbarCont, int>(
        builder: (context, state) {
          return BottomNavBar(
            onChanged: (index) {
              context.read<BottomNavbarCont>().change(index);
              context.goNamed(
                bottomNavigationHandler(index),
              );
            },
            selectedIndex: state,
            items: bottombarItems,
          );
        },
      ),
      body: widget.child,
    );
  }
}
