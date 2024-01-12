import 'package:auto_size_text/auto_size_text.dart';
import 'package:collection/collection.dart';
import 'package:fcc_app_front/features/catalog/data/datasources/catalog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../auth/presentation/cubit/auth_cubit.dart';
import '../../../../shared/config/routes.dart';
import '../../../../shared/constants/colors/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MenuUserInfo extends StatelessWidget {
  const MenuUserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Row(
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Container(
                      height: 48.h,
                      width: 48.h,
                      constraints: const BoxConstraints(
                        maxHeight: 50,
                        minHeight: 40,
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/avatars/fsk.png',
                            ),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            AutoSizeText(
                              state.user.firstName,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              minFontSize: 10,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              width: 100.w,
                              padding: EdgeInsets.symmetric(
                                vertical: 5.h,
                                horizontal: 10.w,
                              ),
                              decoration: BoxDecoration(
                                color: primaryColorDark,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                membershipNames[MembershipType.values.firstWhereOrNull(
                                      (element) => element.name == state.user.membership,
                                    )]
                                        ?.toUpperCase() ??
                                    'План не выбран',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w400,
                                      color: scaffoldBackgroundColor,
                                    ),
                                maxLines: 1,
                                minFontSize: 5,
                                maxFontSize: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Expanded(
                flex: 3,
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      context.goNamed(
                        RoutesNames.invite,
                      );
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        gradient: const LinearGradient(
                          colors: [
                            gradientColor,
                            primaryColor,
                            gradientColor,
                          ],
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 12.w,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "assets/gift.svg",
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(
                            child: AutoSizeText(
                              "Подарок за друга",
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                              minFontSize: 6,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              maxFontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
