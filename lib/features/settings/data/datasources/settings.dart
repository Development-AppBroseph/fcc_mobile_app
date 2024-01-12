import '../models/setting.dart';
import '../../../../shared/config/routes.dart';

final settingsList = List.generate(
  settingIcons.length,
  (index) => SettingModel(
    title: settingTitles[index],
    icon: settingIcons[index],
    route: settingRoutes[index],
  ),
);

const settingTitles = [
  'Сколько человек я пригласил',
  'Сменить план',
  'Уведомления',
  'Настройки',
  'Чат поддержки',
];
const settingIcons = [
  'person_plus',
  'reboot',
  'notif',
  'settings',
  'chat',
];
final settingRoutes = [
  RoutesNames.addPerson,
  RoutesNames.changePlan,
  RoutesNames.notifications,
  RoutesNames.settings,
  RoutesNames.chat,
];
