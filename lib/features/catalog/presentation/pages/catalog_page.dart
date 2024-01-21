import 'package:auto_size_text/auto_size_text.dart';
import 'package:fcc_app_front/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fcc_app_front/features/catalog/data/datasources/catalog.dart';
import 'package:fcc_app_front/features/catalog/data/models/membership.dart';
import 'package:fcc_app_front/features/catalog/presentation/cubit/membership_cubit.dart';
import 'package:fcc_app_front/features/payment/data/repositories/payment_repo.dart';
import 'package:fcc_app_front/shared/config/routes.dart';
import 'package:fcc_app_front/shared/constants/widgets/custom_back.dart';
import 'package:fcc_app_front/shared/constants/widgets/sizedbox.dart';
import 'package:fcc_app_front/shared/widgets/buttons/cstm_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({
    required this.phone,
    Key? key,
  }) : super(key: key);
  final String phone;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<MembershipCubit>(
      create: (BuildContext context) => MembershipCubit()..load(),
      child: Builder(builder: (BuildContext context) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40.w,
              ),
              child: BlocBuilder<MembershipCubit, List<MembershipModel>>(
                builder: (BuildContext context, List<MembershipModel> state) {
                  return SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        if (context.canPop())
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            child: CustomBackButton(),
                          ),
                        Container(
                          height: 120,
                          width: 120,
                          margin: const EdgeInsets.only(top: 25),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            image: const DecorationImage(
                              image: AssetImage('assets/avatars/fsk.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        sized20,
                        AutoSizeText(
                          'ФКК',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                          maxLines: 1,
                        ),
                        sized10,
                        AutoSizeText(
                          'При покупке подписки Вы будете иметь доступ к ассортименту в соответствии с подпиской',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 15,
                              ),
                          maxLines: 2,
                          minFontSize: 12,
                          textAlign: TextAlign.center,
                        ),
                        sized40,
                        Text(
                          'СТАНДАРТ',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        sized10,
                        CstmBtn(
                          onTap: () async {
                            final String? url = await PaymentRepo.getWeblink(
                              1,
                              context.read<MembershipCubit>().getPrice(1),
                            );
                            if (url != null && context.mounted) {
                              context.pushNamed(
                                RoutesNames.payment,
                                extra: <String, Object>{
                                  'paymentUrl': url,
                                  'phone': phone,
                                  'onComplete': (MembershipType type) {
                                    context.read<AuthCubit>().memberShip(
                                          phone,
                                          type,
                                        );
                                    context.goNamed(RoutesNames.paymentCongrats, extra: <String, Object>{
                                      'membership': MembershipType.standard.name,
                                      'goMenu': true,
                                    });
                                  }
                                },
                              );
                            }
                          },
                          text: context.read<MembershipCubit>().getPrice(1),
                          textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontSize: 20,
                                color: Theme.of(context).primaryColorDark,
                              ),
                          color: Theme.of(context).hintColor.withOpacity(0.1),
                        ),
                        sized10,
                        CstmBtn(
                          onTap: () {
                            context.pushNamed(
                              RoutesNames.catalogMenu,
                              pathParameters: <String, String>{
                                'type': MembershipType.standard.name,
                              },
                              extra: BlocProvider.of<MembershipCubit>(context),
                            );
                          },
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).hintColor.withOpacity(0.1),
                          ),
                          height: 39,
                          text: 'Перейти к Стандарт каталогу товаров',
                          textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                              ),
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        sized20,
                        Text(
                          'ПРЕМИУМ',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        sized10,
                        CstmBtn(
                          onTap: () async {
                            final String? url = await PaymentRepo.getWeblink(
                              2,
                              context.read<MembershipCubit>().getPrice(2),
                            );
                            if (url != null && context.mounted) {
                              context.pushNamed(
                                RoutesNames.payment,
                                extra: <String, Object>{
                                  'paymentUrl': url,
                                  'phone': phone,
                                  'onComplete': (MembershipType type) {
                                    context.read<AuthCubit>().memberShip(
                                          phone,
                                          type,
                                        );
                                    context.goNamed(RoutesNames.paymentCongrats, extra: <String, Object>{
                                      'membership': MembershipType.premium.name,
                                      'goMenu': true,
                                    });
                                  }
                                },
                              );
                            }
                          },
                          text: context.read<MembershipCubit>().getPrice(2),
                          textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontSize: 20,
                                color: Theme.of(context).primaryColorDark,
                              ),
                        ),
                        sized10,
                        CstmBtn(
                          onTap: () {
                            context.pushNamed(
                              RoutesNames.catalogMenu,
                              pathParameters: <String, String>{
                                'type': MembershipType.premium.name,
                              },
                              extra: BlocProvider.of<MembershipCubit>(context),
                            );
                          },
                          borderSide: BorderSide(width: 1, color: Theme.of(context).primaryColor),
                          height: 39,
                          text: 'Перейти к Премиум каталогу товаров',
                          textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                              ),
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                        ),
                        sized20,
                        Text(
                          'ЭЛИТ',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        sized10,
                        CstmBtn(
                          onTap: () async {
                            final String? url = await PaymentRepo.getWeblink(
                              3,
                              context.read<MembershipCubit>().getPrice(3),
                            );
                            if (url != null && context.mounted) {
                              context.pushNamed(
                                RoutesNames.payment,
                                extra: <String, Object>{
                                  'paymentUrl': url,
                                  'phone': phone,
                                  'onComplete': (MembershipType type) {
                                    context.read<AuthCubit>().memberShip(
                                          phone,
                                          type,
                                        );
                                    context.goNamed(RoutesNames.paymentCongrats, extra: <String, Object>{
                                      'membership': MembershipType.elite.name,
                                      'goMenu': true,
                                    });
                                  }
                                },
                              );
                            }
                          },
                          text: context.read<MembershipCubit>().getPrice(3),
                          textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontSize: 20,
                                color: Theme.of(context).scaffoldBackgroundColor,
                              ),
                          color: Theme.of(context).primaryColorDark,
                        ),
                        sized10,
                        CstmBtn(
                          onTap: () {
                            context.pushNamed(
                              RoutesNames.catalogMenu,
                              pathParameters: <String, String>{
                                'type': MembershipType.elite.name,
                              },
                              extra: BlocProvider.of<MembershipCubit>(context),
                            );
                          },
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          height: 39,
                          text: 'Перейти к Элит каталогу товаров',
                          textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 12,
                              ),
                          color: Theme.of(context).hintColor.withOpacity(0.1),
                        ),
                        sized20,
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
