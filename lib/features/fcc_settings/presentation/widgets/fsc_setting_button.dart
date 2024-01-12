import 'package:fcc_app_front/features/fcc_settings/data/datasources/content_types.dart';
import 'package:fcc_app_front/features/fcc_settings/data/utils/launch_store.dart';
import 'package:fcc_app_front/features/fcc_settings/presentation/cubit/content_cubit.dart';
import 'package:fcc_app_front/features/settings/data/models/fsc_setting.dart';
import 'package:fcc_app_front/shared/config/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/buttons/filled_btn.dart';

class FscSettingsPageButton extends StatelessWidget {
  const FscSettingsPageButton({
    Key? key,
    required this.setting,
  }) : super(key: key);
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
          if (setting.type == ContentTypeEnum.version) {
            context.pushNamed(
              RoutesNames.version,
            );
          } else if (setting.type == ContentTypeEnum.rate) {
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
        iconPath: "assets/settings/${setting.icon}.svg",
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
