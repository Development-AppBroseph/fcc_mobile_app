import 'package:fcc_app_front/features/notifications/data/utils/save_notification_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/constants/colors/color.dart';
import '../../../../shared/constants/widgets/custom_back.dart';
import '../../../../shared/constants/widgets/sizedbox.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  bool receiveNotifications = false;
  bool pushNotifications = false;
  bool smsNotifications = false;
  @override
  void initState() {
    super.initState();
    receiveNotifications = getReceiveNotifications();
    pushNotifications = getPushNotifications();
    smsNotifications = getSmsNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 35.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(),
              sized30,
              Text(
                "Настройки уведомления",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              sized20,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Получать уведомления",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: hintColor,
                        ),
                  ),
                  CupertinoSwitch(
                    value: receiveNotifications,
                    activeColor: primaryColor,
                    onChanged: (bool value) {
                      setState(() {
                        saveNotificationSettings(
                          receiveNotifications: value,
                        );
                        receiveNotifications = value;
                      });
                    },
                  ),
                ],
              ),
              sized30,
              Row(
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: Checkbox(
                      side: BorderSide(
                        width: 1,
                        color:
                            receiveNotifications ? primaryColorDark : hintColor,
                      ),
                      activeColor: Theme.of(context).primaryColor,
                      visualDensity: VisualDensity.compact,
                      value: pushNotifications,
                      onChanged: receiveNotifications
                          ? (value) {
                              setState(() {
                                saveNotificationSettings(
                                  pushNotifications: value,
                                );
                                pushNotifications = value!;
                              });
                            }
                          : null,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Пуш-уведомления",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: receiveNotifications
                              ? primaryColorDark
                              : hintColor,
                        ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: Checkbox(
                      side: BorderSide(
                        width: 1,
                        color:
                            receiveNotifications ? primaryColorDark : hintColor,
                      ),
                      activeColor: Theme.of(context).primaryColor,
                      visualDensity: VisualDensity.compact,
                      value: smsNotifications,
                      onChanged: receiveNotifications
                          ? (value) {
                              setState(() {
                                saveNotificationSettings(
                                  smsNotifications: value,
                                );
                                smsNotifications = value!;
                              });
                            }
                          : null,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "СМС-оповещения",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: receiveNotifications
                              ? primaryColorDark
                              : hintColor,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
