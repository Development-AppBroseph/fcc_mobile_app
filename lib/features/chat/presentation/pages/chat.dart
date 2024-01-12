import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import '../widgets/chat_appbar.dart';
import '../widgets/chat_textfield.dart';
import '../widgets/message_list.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return const KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
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
