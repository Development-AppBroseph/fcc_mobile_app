import 'package:fcc_app_front/export.dart';

class ChatPage extends StatelessWidget {
  final String id;

  const ChatPage({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              ChatAppBar(),
              MessageList(),
              ChatTextfield(),
            ],
          ),
        ),
      ),
    );
  }
}
