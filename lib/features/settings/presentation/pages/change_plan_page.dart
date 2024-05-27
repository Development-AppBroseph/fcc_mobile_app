
import 'package:fcc_app_front/export.dart';

// class ChangePlanPage extends StatefulWidget {
//   const ChangePlanPage({super.key});
//
//   @override
//   State<ChangePlanPage> createState() => _ChangePlanPageState();
// }
//
// class _ChangePlanPageState extends State<ChangePlanPage> {
//   String removeTrailingZeros(String number) {
//     return number.replaceAll(RegExp(r'(\.0+|(?<=\..*?)0+)$'), '');
//   }
//
//   String? checkMembersheepPrice(String id) {
//     final AuthState user = context.read<AuthCubit>().state;
//     final int parsedMemberSheepPriceById = int.tryParse(id) ?? 0;
//     if (user is Authenticated) {
//       final String userDiscount = user.user.sumDiscount!;
//       int parsedUserDiscount = int.parse(removeTrailingZeros(userDiscount));
//       if (parsedUserDiscount < parsedMemberSheepPriceById) {
//         final String amount =
//             '${parsedMemberSheepPriceById - parsedUserDiscount} ₽';
//         return amount;
//       } else if (parsedUserDiscount >= parsedMemberSheepPriceById) {
//         return '0 ₽';
//       }
//     }
//     return null;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     context.read<AuthCubit>().init();
//     return BlocProvider<MembershipCubit>(
//       create: (BuildContext context) {
//         return MembershipCubit()..load();
//       },
//       child: Builder(
//         builder: (BuildContext context) {
//           final AuthState authState = context.read<AuthCubit>().state;
//           final String phone = authState is Authenticated
//               ? authState.user.phoneNumber ?? ''
//               : '';
//           return LayoutBuilder(
//             builder: (BuildContext context, BoxConstraints constraints) {
//               double availableWidth = constraints.maxWidth;
//               return Scaffold(
//                 body: SafeArea(
//                   child: Padding(
//                     padding: availableWidth < 600
//                         ? const EdgeInsets.only(
//                             left: 30,
//                             right: 30,
//                           )
//                         : EdgeInsets.only(
//                             left: 30 + (availableWidth - 600) / 2,
//                             right: 30 + (availableWidth - 600) / 2,
//                           ),
//                     child: BlocBuilder<MembershipCubit, List<MembershipModel>>(
//                       builder:
//                           (BuildContext context, List<MembershipModel> state) {
//                         return SingleChildScrollView(
//                           child: Column(
//                             children: <Widget>[
//                               const Padding(
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: 10,
//                                 ),
//                                 child: CustomBackButton(
//                                   pop: true,
//                                 ),
//                               ),
//                               Container(
//                                 height: 120,
//                                 width: 120,
//                                 margin: const EdgeInsets.only(top: 25),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(200),
//                                   image: const DecorationImage(
//                                     image: AssetImage('assets/avatars/fsk.png'),
//                                     fit: BoxFit.fill,
//                                   ),
//                                 ),
//                               ),
//                               sized20,
//                               AutoSizeText(
//                                 'ФКК',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyLarge
//                                     ?.copyWith(
//                                       fontWeight: FontWeight.w700,
//                                     ),
//                                 maxLines: 1,
//                               ),
//                               sized10,
//                               AutoSizeText(
//                                 'При покупке подписки Вы будете иметь доступ к ассортименту в соответствии с подпиской',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodySmall
//                                     ?.copyWith(
//                                       fontSize: 15,
//                                     ),
//                                 maxLines: 2,
//                                 minFontSize: 12,
//                                 textAlign: TextAlign.center,
//                               ),
//                               sized40,
//                               Text(
//                                 'СТАНДАРТ',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyLarge
//                                     ?.copyWith(
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                               ),
//                               sized10,
//                               CstmBtn(
//                                 onTap: () async {
//                                   final String? url =
//                                       await PaymentRepo.getWeblink(
//                                     1,
//                                     context.read<MembershipCubit>().getPrice(1),
//                                   );
//
//                                   if (url == 'free' && context.mounted) {
//                                     context.pushNamed(
//                                       RoutesNames.freePaymentCongatulation,
//                                       extra: <String, Object>{
//                                         'membership':
//                                             MembershipType.standard.name,
//                                       },
//                                     );
//                                     return;
//                                   }
//
//                                   if (url != null && context.mounted) {
//                                     context.pushNamed(
//                                       RoutesNames.payment,
//                                       extra: <String, dynamic>{
//                                         'paymentUrl': url,
//                                         'phone': phone,
//                                         'onComplete': () async {
//                                           context.pop();
//                                           Future.delayed(
//                                             Duration.zero,
//                                             () {
//                                               context
//                                                   .read<AuthCubit>()
//                                                   .memberShip(
//                                                     phone,
//                                                     MembershipType.standard,
//                                                   );
//                                               context.read<ProductCubit>().load(
//                                                     isPublic: context
//                                                             .read<AuthCubit>()
//                                                             .state
//                                                         is Unauthenticated,
//                                                   );
//
//                                               context.pushNamed(
//                                                   RoutesNames.paymentCongrats,
//                                                   extra: <String, Object>{
//                                                     'membership': MembershipType
//                                                         .standard.name,
//                                                     'goMenu': false,
//                                                   });
//                                             },
//                                           );
//                                         }
//                                       },
//                                     );
//                                   }
//                                 },
//                                 text: checkMembersheepPrice(context
//                                     .read<MembershipCubit>()
//                                     .getPrice(1))!,
//                                 textStyle: Theme.of(context)
//                                     .textTheme
//                                     .titleMedium
//                                     ?.copyWith(
//                                       fontSize: 20,
//                                       color: Theme.of(context).primaryColorDark,
//                                     ),
//                                 color: Theme.of(context)
//                                     .hintColor
//                                     .withOpacity(0.1),
//                               ),
//                               sized10,
//                               CstmBtn(
//                                 onTap: () {
//                                   context.pushNamed(
//                                     RoutesNames.catalogMenuProfile,
//                                     pathParameters: <String, String>{
//                                       'type': MembershipType.standard.name,
//                                     },
//                                     extra: BlocProvider.of<MembershipCubit>(
//                                         context),
//                                   );
//                                 },
//                                 borderSide: BorderSide(
//                                   width: 1,
//                                   color: Theme.of(context)
//                                       .hintColor
//                                       .withOpacity(0.1),
//                                 ),
//                                 height: 39,
//                                 text: 'Перейти к Стандарт каталогу товаров',
//                                 textStyle: Theme.of(context)
//                                     .textTheme
//                                     .bodySmall
//                                     ?.copyWith(
//                                       fontSize: 12,
//                                     ),
//                                 color:
//                                     Theme.of(context).scaffoldBackgroundColor,
//                               ),
//                               sized20,
//                               Text(
//                                 'ПРЕМИУМ',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyLarge
//                                     ?.copyWith(
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                               ),
//                               sized10,
//                               CstmBtn(
//                                 onTap: () async {
//                                   final String? url =
//                                       await PaymentRepo.getWeblink(
//                                     2,
//                                     context.read<MembershipCubit>().getPrice(2),
//                                   );
//
//                                   if (url == 'free' && context.mounted) {
//                                     context.pushNamed(
//                                       RoutesNames.freePaymentCongatulation,
//                                       extra: <String, Object>{
//                                         'membership':
//                                             MembershipType.premium.name,
//                                       },
//                                     );
//                                     return;
//                                   }
//
//                                   if (url != null && context.mounted) {
//                                     context.pushNamed(
//                                       RoutesNames.payment,
//                                       extra: <String, dynamic>{
//                                         'paymentUrl': url,
//                                         'phone': phone,
//                                         'onComplete': () async {
//                                           context.pop();
//                                           Future.delayed(
//                                             Duration.zero,
//                                             () {
//                                               context
//                                                   .read<AuthCubit>()
//                                                   .memberShip(
//                                                     phone,
//                                                     MembershipType.premium,
//                                                   );
//                                               context.read<ProductCubit>().load(
//                                                     isPublic: context
//                                                             .read<AuthCubit>()
//                                                             .state
//                                                         is Unauthenticated,
//                                                   );
//
//                                               context.pushNamed(
//                                                   RoutesNames.paymentCongrats,
//                                                   extra: <String, Object>{
//                                                     'membership': MembershipType
//                                                         .premium.name,
//                                                     'goMenu': false,
//                                                   });
//                                             },
//                                           );
//                                         }
//                                       },
//                                     );
//                                   }
//                                 },
//                                 text: checkMembersheepPrice(
//                                   context.read<MembershipCubit>().getPrice(2),
//                                 )!,
//                                 textStyle: Theme.of(context)
//                                     .textTheme
//                                     .titleMedium
//                                     ?.copyWith(
//                                       fontSize: 20,
//                                       color: Theme.of(context).primaryColorDark,
//                                     ),
//                               ),
//                               sized10,
//                               CstmBtn(
//                                 onTap: () {
//                                   context.pushNamed(
//                                     RoutesNames.catalogMenuProfile,
//                                     pathParameters: <String, String>{
//                                       'type': MembershipType.premium.name,
//                                     },
//                                     extra: BlocProvider.of<MembershipCubit>(
//                                         context),
//                                   );
//                                 },
//                                 borderSide: BorderSide(
//                                   width: 1,
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                                 height: 39,
//                                 text: 'Перейти к Премиум каталогу товаров',
//                                 textStyle: Theme.of(context)
//                                     .textTheme
//                                     .bodySmall
//                                     ?.copyWith(
//                                       fontSize: 12,
//                                     ),
//                                 color: Theme.of(context)
//                                     .primaryColor
//                                     .withOpacity(0.1),
//                               ),
//                               sized20,
//                               Text(
//                                 'ЭЛИТ',
//                                 style: Theme.of(context)
//                                     .textTheme
//                                     .bodyLarge
//                                     ?.copyWith(
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                               ),
//                               sized10,
//                               CstmBtn(
//                                 onTap: () async {
//                                   final String? url =
//                                       await PaymentRepo.getWeblink(
//                                     3,
//                                     context.read<MembershipCubit>().getPrice(3),
//                                   );
//
//                                   if (url == 'free' && context.mounted) {
//                                     context.pushNamed(
//                                       RoutesNames.freePaymentCongatulation,
//                                       extra: <String, Object>{
//                                         'membership': MembershipType.elite.name,
//                                       },
//                                     );
//                                     return;
//                                   }
//
//                                   if (url != null && context.mounted) {
//                                     context.pushNamed(
//                                       RoutesNames.payment,
//                                       extra: <String, dynamic>{
//                                         'paymentUrl': url,
//                                         'phone': phone,
//                                         'onComplete': () async {
//                                           context.pop();
//                                           Future<void>.delayed(
//                                             Duration.zero,
//                                             () {
//                                               context
//                                                   .read<AuthCubit>()
//                                                   .memberShip(
//                                                     phone,
//                                                     MembershipType.elite,
//                                                   );
//                                               context.read<ProductCubit>().load(
//                                                     isPublic: context
//                                                             .read<AuthCubit>()
//                                                             .state
//                                                         is Unauthenticated,
//                                                   );
//
//                                               context.pushNamed(
//                                                   RoutesNames.paymentCongrats,
//                                                   extra: <String, Object>{
//                                                     'membership': MembershipType
//                                                         .elite.name,
//                                                     'goMenu': false,
//                                                   });
//                                             },
//                                           );
//                                         }
//                                       },
//                                     );
//                                   }
//                                 },
//                                 text: checkMembersheepPrice(context
//                                     .read<MembershipCubit>()
//                                     .getPrice(3))!,
//                                 textStyle: Theme.of(context)
//                                     .textTheme
//                                     .titleMedium
//                                     ?.copyWith(
//                                       fontSize: 20,
//                                       color: Theme.of(context)
//                                           .scaffoldBackgroundColor,
//                                     ),
//                                 color: Theme.of(context).primaryColorDark,
//                               ),
//                               sized10,
//                               CstmBtn(
//                                 onTap: () {
//                                   context.pushNamed(
//                                     RoutesNames.catalogMenuProfile,
//                                     pathParameters: <String, String>{
//                                       'type': MembershipType.elite.name,
//                                     },
//                                     extra: BlocProvider.of<MembershipCubit>(
//                                         context),
//                                   );
//                                 },
//                                 borderSide: BorderSide(
//                                   width: 1,
//                                   color: Theme.of(context).primaryColorDark,
//                                 ),
//                                 height: 39,
//                                 text: 'Перейти к Элит каталогу товаров',
//                                 textStyle: Theme.of(context)
//                                     .textTheme
//                                     .bodySmall
//                                     ?.copyWith(
//                                       fontSize: 12,
//                                     ),
//                                 color: Theme.of(context)
//                                     .hintColor
//                                     .withOpacity(0.1),
//                               ),
//                               sized20,
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }




class ChangePlanPage extends StatefulWidget {

  const ChangePlanPage({super.key});



  @override

  State<ChangePlanPage> createState() => _ChangePlanPageState();

}



class _ChangePlanPageState extends State<ChangePlanPage> {

  String removeTrailingZeros(String number) {

    return number.replaceAll(RegExp(r'(\.0+|(?<=\..*?)0+)$'), '');

  }



  String? checkMembershipPrice(String id) {

    final AuthState user = context.read<AuthCubit>().state;

    final int parsedMembershipPriceById = int.tryParse(id) ?? 0;

    if (user is Authenticated) {

      final String userDiscount = user.user.sumDiscount!;

      int parsedUserDiscount = int.parse(removeTrailingZeros(userDiscount));

      if (parsedUserDiscount < parsedMembershipPriceById) {

        final String amount = '${parsedMembershipPriceById - parsedUserDiscount} ₽';

        return amount;

      } else if (parsedUserDiscount >= parsedMembershipPriceById) {

        return '0 ₽';

      }

    }

    return null;

  }



  @override

  void initState() {

    super.initState();

  }



  @override

  Widget build(BuildContext context) {

    context.read<AuthCubit>().init();



    return BlocProvider<MembershipCubit>(

      create: (BuildContext context) {

        return MembershipCubit()..load();

      },

      child: Builder(

        builder: (BuildContext context) {

          final AuthState authState = context.read<AuthCubit>().state;

          final String phone = authState is Authenticated ? authState.user.phoneNumber ?? '' : '';



          return LayoutBuilder(

            builder: (BuildContext context, BoxConstraints constraints) {

              double availableWidth = constraints.maxWidth;



              return Scaffold(

                body: SafeArea(

                  child: Padding(

                    padding: availableWidth < 600

                        ? const EdgeInsets.only(left: 30, right: 30)

                        : EdgeInsets.only(

                      left: 30 + (availableWidth - 600) / 2,

                      right: 30 + (availableWidth - 600) / 2,

                    ),

                    child: BlocBuilder<MembershipCubit, List<MembershipModel>>(

                      builder: (BuildContext context, List<MembershipModel> state) {

                        if (state.isEmpty) {

                          return Center(

                            child: CircularProgressIndicator(color: primaryColorDark),

                          );

                        }



                        return SingleChildScrollView(

                          child: Column(

                            children: <Widget>[

                              const Padding(

                                padding: EdgeInsets.symmetric(vertical: 10),

                                child: CustomBackButton(pop: true),

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

                              _buildMembershipButton(context, 1, MembershipType.standard, phone, isElite: false),

                              sized10,

                              _buildCatalogButton(

                                context,

                                1,

                                'Перейти к Стандарт каталогу товаров',

                                '1',

                                Theme.of(context).scaffoldBackgroundColor,

                                Theme.of(context).hintColor.withOpacity(0.1),

                              ),

                              sized20,

                              Text(

                                'ПРЕМИУМ',

                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(

                                  fontWeight: FontWeight.w500,

                                ),

                              ),

                              sized10,

                              _buildMembershipButton(context, 2, MembershipType.premium, phone, isElite: false),

                              sized10,

                              _buildCatalogButton(

                                context,

                                2,

                                'Перейти к Премиум каталогу товаров',

                                '2',

                                Theme.of(context).primaryColor.withOpacity(0.1),

                                Theme.of(context).primaryColor,

                              ),

                              sized20,

                              Text(

                                'ЭЛИТ',

                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(

                                  fontWeight: FontWeight.w500,

                                ),

                              ),

                              sized10,

                              _buildMembershipButton(context, 3, MembershipType.elite, phone, isElite: true),

                              sized10,

                              _buildCatalogButton(

                                context,

                                3,

                                'Перейти к Элит каталогу товаров',

                                '3',

                                Theme.of(context).hintColor.withOpacity(0.1),

                                Theme.of(context).primaryColorDark,

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

            },

          );

        },

      ),

    );

  }



  Widget _buildMembershipButton(BuildContext context, int id, MembershipType type, String phone, {bool isElite = false}) {

    bool isAvailable = context.read<MembershipCubit>().isAvailable(id);

    return CstmBtn(

      onTap: isAvailable

          ? () async {

        final String? url = await PaymentRepo.getWeblink(id, context.read<MembershipCubit>().getPrice(id));

        if (url == 'free' && context.mounted) {

          context.pushNamed(

            RoutesNames.freePaymentCongatulation,

            extra: <String, Object>{'membership': type.name},

          );

          return;

        }

        if (url != null && context.mounted) {

          context.pushNamed(

            RoutesNames.payment,

            extra: <String, dynamic>{

              'paymentUrl': url,

              'phone': phone,

              'onComplete': () async {

                context.pop();

                Future.delayed(

                  Duration.zero,

                      () {

                    context.read<AuthCubit>().memberShip(phone, type);

                    context.read<ProductCubit>().load(isPublic: context.read<AuthCubit>().state is Unauthenticated);

                    context.pushNamed(

                      RoutesNames.paymentCongrats,

                      extra: <String, Object>{

                        'membership': type.name,

                        'goMenu': false,

                      },

                    );

                  },

                );

              },

            },

          );

        }

      }

          : () {},

      text: isAvailable ? checkMembershipPrice(context.read<MembershipCubit>().getPrice(id))! : 'Тариф недоступен',

      textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(

        fontSize: 20,

        color: isElite ? (isAvailable ? Theme.of(context).scaffoldBackgroundColor : Colors.grey) : (isAvailable ? Theme.of(context).primaryColorDark : Colors.grey),

      ),

      color: _getButtonColor(context, id, isAvailable),

    );

  }



  Widget _buildCatalogButton(BuildContext context, int id, String text, String extra, Color color, Color borderColor) {

    bool isAvailable = context.watch<MembershipCubit>().isAvailable(id);

    return CstmBtn(

      onTap: isAvailable

          ? () {

        context.pushNamed(

          RoutesNames.catalogMenuProfile,

          pathParameters: <String, String>{'type': MembershipType.values[id - 1].name},

          extra: BlocProvider.of<MembershipCubit>(context),

        );

      }

          : () {},

      borderSide: BorderSide(

        width: 1,

        color: isAvailable ? borderColor : Colors.grey,

      ),

      height: 39,

      text: isAvailable ? text : 'Товаров нет в наличии',

      textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(

        fontSize: 12,

      ),

      color: isAvailable ? color : Colors.grey.withOpacity(0.5),

    );

  }



  Color _getButtonColor(BuildContext context, int id, bool isAvailable) {

    if (id == 1) {

      return isAvailable ? Theme.of(context).hintColor.withOpacity(0.1) : Colors.grey.withOpacity(0.5);

    } else if (id == 2) {

      return isAvailable ? Theme.of(context).primaryColor : Colors.grey.withOpacity(0.5);

    } else if (id == 3) {

      return isAvailable ? Theme.of(context).primaryColorDark : Colors.grey.withOpacity(0.5);

    } else {

      return Colors.grey.withOpacity(0.5);

    }

  }

}