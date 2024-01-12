import 'package:auto_animated/auto_animated.dart';
import 'package:fcc_app_front/features/fcc_settings/presentation/widgets/fsc_setting_button.dart';

import '../../data/datasources/fsc_settings.dart';
import '../../../../shared/constants/widgets/custom_back.dart';
import '../../../../shared/constants/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FscSettingsPage extends StatefulWidget {
  const FscSettingsPage({super.key});

  @override
  State<FscSettingsPage> createState() => _FscSettingsPageState();
}

class _FscSettingsPageState extends State<FscSettingsPage> {
  late ScrollController _scrollController;
  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 35.w,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: CustomBackButton(),
                    ),
                    Text(
                      "ФКК",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    sized40,
                  ],
                ),
              ),
              LiveSliverList(
                controller: _scrollController,
                showItemInterval: const Duration(milliseconds: 150),
                showItemDuration: const Duration(milliseconds: 200),
                itemBuilder: (context, index, animation) => FadeTransition(
                  opacity: Tween<double>(
                    begin: 0,
                    end: 1,
                  ).animate(animation),
                  // And slide transition
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, -0.1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: FscSettingsPageButton(
                      setting: fscSettingsList[index],
                    ),
                  ),
                ),
                itemCount: fscSettingsList.length,
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                fillOverscroll: false,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: FutureBuilder(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapshot) {
                        return Text(
                          "Версия приложения: ${snapshot.data?.version ?? 'Подождите'}",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Theme.of(context).hintColor,
                                  ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
