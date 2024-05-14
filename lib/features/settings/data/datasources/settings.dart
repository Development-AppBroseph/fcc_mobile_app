import 'package:fcc_app_front/export.dart';

final List<SettingModel> settingsList = List<SettingModel>.generate(
  settingIcons.length,
  (int index) => SettingModel(
    title: settingTitles[index],
    icon: settingIcons[index],
    route: settingRoutes[index],
  ),
);

const List<String> settingTitles = <String>[
  'Сколько человек я пригласил',
  //'Сменить план',
  'Уведомления',
  'Настройки',
  'Чат поддержки',
];
const List<String> settingIcons = <String>[
  'person_plus',
  //'reboot',
  'notif',
  'settings',
  'chat',
];
final List<String> settingRoutes = <String>[
  RoutesNames.addPerson,
  // RoutesNames.changePlan,
  RoutesNames.notifications,
  RoutesNames.settings,
  RoutesNames.chat,
];
