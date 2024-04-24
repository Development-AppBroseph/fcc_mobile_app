import 'package:fcc_app_front/export.dart';

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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double boxWidth = constraints.maxWidth;

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: boxWidth < 600
                  ? const EdgeInsets.only(
                      left: 30,
                      right: 30,
                    )
                  : EdgeInsets.only(
                      left: 30 + (boxWidth - 600) / 2,
                      right: 30 + (boxWidth - 600) / 2,
                    ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CustomBackButton(),
                  sized30,
                  Text(
                    'Настройки уведомления',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  sized20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Получать уведомления',
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
                    children: <Widget>[
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: Checkbox(
                          side: BorderSide(
                            width: 1,
                            color: receiveNotifications
                                ? primaryColorDark
                                : hintColor,
                          ),
                          activeColor: Theme.of(context).primaryColor,
                          visualDensity: VisualDensity.compact,
                          value: pushNotifications,
                          onChanged: receiveNotifications
                              ? (bool? value) {
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
                        'Пуш-уведомления',
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
                    children: <Widget>[
                      SizedBox(
                        height: 18,
                        width: 18,
                        child: Checkbox(
                          side: BorderSide(
                            width: 1,
                            color: receiveNotifications
                                ? primaryColorDark
                                : hintColor,
                          ),
                          activeColor: Theme.of(context).primaryColor,
                          visualDensity: VisualDensity.compact,
                          value: smsNotifications,
                          onChanged: receiveNotifications
                              ? (bool? value) {
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
                        'СМС-оповещения',
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
      },
    );
  }
}
