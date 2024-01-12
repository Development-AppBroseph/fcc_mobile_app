import 'package:fcc_app_front/features/fcc_settings/data/datasources/content_types.dart';

class FscSettingModel {
  final String title;
  final String icon;
  final ContentTypeEnum type;
  FscSettingModel({
    required this.title,
    required this.icon,
    required this.type,
  });
}
