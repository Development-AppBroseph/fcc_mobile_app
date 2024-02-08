import 'package:fcc_app_front/export.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider(
          create: (BuildContext context) => BottomNavbarCont(),
        ),
        BlocProvider(
          create: (BuildContext context) => ProductCubit()
            ..load(
              isPublic: context.read<AuthCubit>().state is Unauthenticated,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => ContentCubit()..load(),
        ),
        BlocProvider(
          create: (BuildContext context) => OrderCubit()..load(),
        ),
        BlocProvider(
          create: (BuildContext context) => CatalogCubit()
            ..load(
              isPublic: context.read<AuthCubit>().state is Unauthenticated,
            ),
        ),
        BlocProvider(
          create: (BuildContext context) => InvitationCubit()..load(),
        ),
        BlocProvider(
          create: (BuildContext context) => DiscountCubit()..load(),
        ),
      ],
      child: Builder(builder: (BuildContext context) {
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
      (Duration timeStamp) async {
        //   await FirebaseNotificationsRepo().sendFcm();
        await FirebaseMessaging.instance.getInitialMessage();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<BottomNavbarCont, int>(
        builder: (BuildContext context, int state) {
          return BottomNavBar(
            onChanged: (int index) {
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
