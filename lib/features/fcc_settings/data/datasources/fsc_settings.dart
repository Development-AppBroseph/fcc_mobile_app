import 'package:fcc_app_front/features/fcc_settings/data/datasources/content_types.dart';
import 'package:fcc_app_front/features/settings/data/models/fsc_setting.dart';

final List<FscSettingModel> fscSettingsList = List<FscSettingModel>.generate(
  fscSettingIcons.length,
  (int index) => FscSettingModel(
    title: fscSettingTitles[index],
    icon: fscSettingIcons[index],
    type: ContentTypeEnum.values.elementAt(index),
  ),
);

const List<String> fscSettingTitles = <String>[
  'О нас',
  'Оставить отзыв',
  'Условия использования',
  'Лицензии открытого ПО',
  'Версия',
  'Политика конфиденциальности',
];
const List<String> fscSettingIcons = <String>[
  'about_us',
  'rate',
  'terms_of_use',
  'license_of_open_source_software',
  'version',
  'privacy_policy',
];
