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
        BlocProvider<BottomNavbarCont>(
          create: (BuildContext context) => BottomNavbarCont()..change(1),
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

    // final IOWebSocketChannel channel = IOWebSocketChannel.connect(
    //   Uri.parse(socketUrl),
    //   headers: <String, String>{
    //     'Authorization': 'Bearer ${getToken()}',
    //     'Origin': baseUrl,
    //   },
    // );

    // channel.stream.listen((dynamic event) {
    //   MessageModel parsed = MessageModel.fromJson(jsonDecode(event));
    //   ValueNotifier<bool> isAdmin =
    //       ValueNotifier<bool>(parsed.message.clientSend);

    //   if (!isAdmin.value) {
    //     NotificationApi.pushLocaleNotification(
    //       'ФКК',
    //       parsed.message.message ??
    //           parsed.message.file.toString().split('/').last,
    //     );
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocConsumer<BottomNavbarCont, int>(
        listener: (BuildContext context, int state) {
          context.read<BottomNavbarCont>().change(state);
        },
        builder: (BuildContext context, int state) {
          return BottomNavBar(
            onChanged: (int index) {
              context.read<BottomNavbarCont>().change(index);
              context.pushNamed(
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
