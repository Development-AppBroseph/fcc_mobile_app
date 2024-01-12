import 'package:fcc_app_front/features/chat/data/utils/check_first_message.dart';

import '../../data/models/message.dart';
import '../cubit/chat_cubit.dart';
import 'message.dart';
import '../../../../shared/constants/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: BlocBuilder<ChatCubit, List<MessageModel>>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.w,
          ),
          child: state.isEmpty
              ? Center(
                  child: Text(
                    'Cообщений пока не было',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                )
              : ListView.separated(
                  reverse: true,
                  itemBuilder: (context, index) => ChatMessageContainer(
                    message: state[index],
                    isFirstOfDay: index == state.length - 1 ||
                        index < state.length - 1 &&
                            checkFirstMessage(
                              state[index],
                              state[index + 1],
                            ),
                  ),
                  separatorBuilder: (context, index) => sized20,
                  itemCount: state.length,
                ),
        );
      },
    ));
  }
}
