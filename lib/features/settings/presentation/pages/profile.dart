import 'package:auto_animated/auto_animated.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../data/datasources/settings.dart';
import '../widgets/settings_page_button.dart';
import '../../../../shared/constants/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            horizontal: 35.0.w,
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Animate(
                  effects: const [
                    FadeEffect(),
                    ScaleEffect(),
                  ],
                  child: Column(
                    children: [
                      sized20,
                      ClipOval(
                        child: Image.asset(
                          'assets/avatars/fsk.png',
                          height: 120.h,
                        ),
                      ),
                      sized20,
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is Authenticated) {
                            return Column(
                              children: [
                                Text(
                                  "${state.user.lastName} ${state.user.firstName} ${state.user.middleName}",
                                  style:
                                      Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                  textAlign: TextAlign.center,
                                ),
                                sized10,
                                Text(
                                  state.user.phoneNumber,
                                  style:
                                      Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w400,
                                            color: Theme.of(context).hintColor,
                                          ),
                                  textAlign: TextAlign.center,
                                ),
                                sized30,
                              ],
                            );
                          }
                          return SizedBox.fromSize();
                        },
                      ),
                    ],
                  ),
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
                    child: SettingsPageButton(
                      setting:
                          settingsList[index == settingsList.length ? index - 1 : index],
                      isFsc: index == settingsList.length,
                    ),
                  ),
                ),
                itemCount: settingsList.length + 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
