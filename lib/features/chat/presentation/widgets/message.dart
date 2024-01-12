import 'package:cached_network_image/cached_network_image.dart';
import 'package:fcc_app_front/features/chat/data/utils/date_string.dart';
import 'package:fcc_app_front/features/fcc_settings/data/utils/launch_store.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/constants/colors/color.dart';
import '../../../../shared/constants/widgets/sizedbox.dart';
import '../../data/models/message.dart';

class ChatMessageContainer extends StatelessWidget {
  const ChatMessageContainer({
    Key? key,
    required this.message,
    this.isFirstOfDay = false,
  }) : super(key: key);
  final MessageModel message;
  final bool isFirstOfDay;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          sized10,
          if (isFirstOfDay)
            Text(
              getDateString(
                message.date,
              ),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          sized10,
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment:
                message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!message.isMine)
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(
                        'assets/avatars/fsk.png',
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!message.isMine)
                    Text(
                      'Поддержка',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  const SizedBox(
                    height: 5,
                  ),
                  if (message.image != null)
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: SizedBox(
                            width: 300.w,
                            child: CachedNetworkImage(
                              imageUrl: message.image!,
                              placeholder: (context, url) => Container(
                                width: 300.w,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: message.isMine ? textColor : primaryColorLight,
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                width: 300.w,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: message.isMine ? textColor : primaryColorLight,
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.error,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        sized10,
                      ],
                    ),
                  if (message.message != null && message.message != '')
                    SizedBox(
                      width: 300.w,
                      child: Row(
                        mainAxisAlignment: message.isMine
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: 300.w,
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: message.isMine ? textColor : primaryColorLight,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: message.id == -1
                                ? RichText(
                                    text: TextSpan(
                                        text: 'Онлайн поддержка в WhatsApp и Telegram',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                        children: [
                                          TextSpan(
                                            text: ' WhatsApp ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 14,
                                                  color: textColor,
                                                  decoration: TextDecoration.underline,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                launchWhatsapp();
                                              },
                                          ),
                                          const TextSpan(
                                            text: 'и',
                                          ),
                                          TextSpan(
                                            text: ' Telegram ',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  fontSize: 14,
                                                  color: textColor,
                                                  decoration: TextDecoration.underline,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                launchTelegram();
                                              },
                                          ),
                                        ]),
                                  )
                                : Text(
                                    message.message ?? '',
                                    style:
                                        Theme.of(context).textTheme.bodySmall?.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              if (message.isMine)
                const Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: hintColor,
                      child: Icon(
                        Icons.person,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          sized10,
        ],
      ),
    );
  }
}
