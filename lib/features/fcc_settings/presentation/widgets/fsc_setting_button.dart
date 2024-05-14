import 'package:fcc_app_front/export.dart';

class FscSettingsPageButton extends StatelessWidget {
  const FscSettingsPageButton({
    super.key,
    required this.setting,
  });
  final FscSettingModel setting;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
      ),
      child: FillBtn(
        text: setting.title,
        onTap: () async {
          if (setting.type == ContentTypeEnum.rate) {
            launchStore();
          } else {
            context.pushNamed(
              RoutesNames.fscProfileData,
              extra: MapEntry(
                setting.title,
                await context.read<ContentCubit>().getContent(
                      setting.type,
                    ),
              ),
            );
          }
        },
        iconPath: 'assets/settings/${setting.icon}.svg',
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
