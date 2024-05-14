import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/settings/presentation/widgets/offer_cart.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double boxWidth = constraints.maxWidth;

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: boxWidth < 600
                  ? const EdgeInsets.only(
                      left: 30,
                      right: 30,
                    )
                  : EdgeInsets.only(
                      left: 30 + (boxWidth - 600) / 2,
                      right: 30 + (boxWidth - 600) / 2,
                      bottom: 30),
              child: Column(
                children: <Widget>[
                  const CustomBackButton(),
                  const Spacer(),
                  AutoSizeText(
                    'Сколько человек я пригласил',
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: BlocBuilder<AuthCubit, AuthState>(
                      builder: (BuildContext context, AuthState state) {
                        if (state is Authenticated) {
                          return Column(
                            children: <Widget>[
                              AutoSizeText.rich(
                                TextSpan(
                                  children: <InlineSpan>[
                                    const TextSpan(
                                      text: 'Вы пригласили ',
                                    ),
                                    TextSpan(
                                      text:
                                          '${state.user.invitedCount} человек',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    )
                                  ],
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: hintColor,
                                    ),
                                maxLines: 1,
                              ),
                              sized10,
                              Text(
                                'Пользователи, которые зашли по вашей реферальной ссылке',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 12,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              sized40,
                              OfferCart(
                                borderColor: Theme.of(context).primaryColor,
                                title: '${state.user.userDiscount} %',
                                titleStyle:
                                    Theme.of(context).textTheme.titleLarge,
                                onTap: () {},
                                description: 'Ваш процент скидки',
                                descriptionStyle: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 14,
                                      color: hintColor,
                                    ),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
