// import 'package:fcc_app_front/export.dart';
//
// class IntroCatalogPage extends StatelessWidget {
//   const IntroCatalogPage({
//     super.key,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (BuildContext context) => MembershipCubit()..load(),
//       child: Builder(
//         builder: (BuildContext context) {
//           return LayoutBuilder(
//             builder: (BuildContext context, BoxConstraints constraints) {
//               final double boxWidth = constraints.maxWidth;
//
//               return Scaffold(
//                 body: SafeArea(
//                   child: Padding(
//                     padding: boxWidth < 600
//                         ? const EdgeInsets.only(
//                             left: 30,
//                             right: 30,
//                           )
//                         : EdgeInsets.only(
//                             left: 30 + (boxWidth - 600) / 2,
//                             right: 30 + (boxWidth - 600) / 2,
//                             bottom: 30),
//                     child: BlocBuilder<MembershipCubit, List<MembershipModel>>(
//                       builder:
//                           (BuildContext context, List<MembershipModel> state) {
//                         return SingleChildScrollView(
//                           child: Column(
//                             children: <Widget>[
//                               if (context.canPop())
//                                 const Padding(
//                                   padding: EdgeInsets.symmetric(
//                                     vertical: 10,
//                                   ),
//                                   child: CustomBackButton(),
//                                 ),
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
//                                 onTap: () {
//                                   context
//                                       .read<SelectedMembershipCubit>()
//                                       .change(MembershipType.standard);
//
//                                   context.goNamed(
//                                     RoutesNames.invite,
//                                   );
//                                 },
//                                 text:
//                                     context.read<MembershipCubit>().getPrice(1),
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
//                                   context
//                                       .read<CatalogCubit>()
//                                       .getAllCatalogsById(
//                                         '1',
//                                       );
//                                   context
//                                       .read<SelectedMembershipCubit>()
//                                       .change(MembershipType.standard);
//                                   context.goNamed(RoutesNames.menu, extra: '1');
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
//                                 onTap: () {
//                                   context
//                                       .read<SelectedMembershipCubit>()
//                                       .change(MembershipType.premium);
//                                   context.goNamed(
//                                     RoutesNames.invite,
//                                   );
//                                 },
//                                 text:
//                                     context.read<MembershipCubit>().getPrice(2),
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
//                                   context
//                                       .read<CatalogCubit>()
//                                       .getAllCatalogsById(
//                                         '2',
//                                       );
//                                   context
//                                       .read<SelectedMembershipCubit>()
//                                       .change(
//                                         MembershipType.premium,
//                                       );
//                                   context.goNamed(RoutesNames.menu, extra: '2');
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
//                                 onTap: () {
//                                   context
//                                       .read<SelectedMembershipCubit>()
//                                       .change(
//                                         MembershipType.elite,
//                                       );
//                                   context.goNamed(
//                                     RoutesNames.invite,
//                                   );
//                                 },
//                                 text:
//                                     context.read<MembershipCubit>().getPrice(3),
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
//                                   context
//                                       .read<CatalogCubit>()
//                                       .getAllCatalogsById(
//                                         '3',
//                                       );
//                                   context
//                                       .read<SelectedMembershipCubit>()
//                                       .change(MembershipType.elite);
//                                   context.goNamed(RoutesNames.menu, extra: '3');
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
//
import 'package:fcc_app_front/export.dart';



class IntroCatalogPage extends StatelessWidget {

  const IntroCatalogPage({super.key});



  @override

  Widget build(BuildContext context) {

    return BlocProvider(

      create: (BuildContext context) => MembershipCubit()..load(),

      child: Builder(

        builder: (BuildContext context) {

          return LayoutBuilder(

            builder: (BuildContext context, BoxConstraints constraints) {

              final double boxWidth = constraints.maxWidth;

              return Scaffold(

                body: SafeArea(

                  child: Padding(

                    padding: boxWidth < 600

                        ? const EdgeInsets.only(left: 30, right: 30)

                        : EdgeInsets.only(

                        left: 30 + (boxWidth - 600) / 2,

                        right: 30 + (boxWidth - 600) / 2,

                        bottom: 30),

                    child: BlocBuilder<MembershipCubit, List<MembershipModel>>(

                      builder: (BuildContext context, List<MembershipModel> state) {

                        if (state.isEmpty) {

                          return Center(

                            child: CircularProgressIndicator(color: primaryColorDark,),

                          );

                        }



                        return SingleChildScrollView(

                          child: Column(

                            children: <Widget>[

                              if (context.canPop())

                                const Padding(

                                  padding: EdgeInsets.symmetric(vertical: 10),

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

                              _buildMembershipButton(context, 1, MembershipType.standard, RoutesNames.invite),

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

                              _buildMembershipButton(context, 2, MembershipType.premium, RoutesNames.invite),

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

                              _buildMembershipButton(context, 3, MembershipType.elite, RoutesNames.invite, isElite: true),

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



  Widget _buildMembershipButton(BuildContext context, int id, MembershipType type, String route, {bool isElite = false}) {

    bool isAvailable = context.read<MembershipCubit>().isAvailable(id);

    return CstmBtn(

      onTap: isAvailable

          ? () {

        context.read<SelectedMembershipCubit>().change(type);

        context.goNamed(route);

      }

          : () {},

      text: context.read<MembershipCubit>().getPrice(id),

      textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(

        fontSize: 20,

        color: isElite

            ? (isAvailable

            ? Theme.of(context).scaffoldBackgroundColor

            : Colors.grey)

            : (isAvailable ? Theme.of(context).primaryColorDark : Colors.grey),

      ),

      color: _getButtonColor(context, id, isAvailable),

    );

  }



  Widget _buildCatalogButton(BuildContext context, int id, String text, String extra, Color color, Color borderColor) {

    bool isAvailable = context.read<MembershipCubit>().isAvailable(id);

    return CstmBtn(

      onTap: isAvailable

          ? () {

        context.read<CatalogCubit>().getAllCatalogsById(extra);

        context.read<SelectedMembershipCubit>().change(MembershipType.values[id - 1]);

        context.goNamed(RoutesNames.menu, extra: extra);

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