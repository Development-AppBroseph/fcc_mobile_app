import 'package:fcc_app_front/export.dart';
import 'package:fcc_app_front/features/settings/presentation/widgets/offer_cart.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double boxWidth = constraints.constrainWidth();

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
                  CustomBackButton(),
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
                    child: BlocBuilder<DiscountCubit, DiscountState>(
                      builder: (BuildContext context, DiscountState state) {
                        return Column(
                          children: <Widget>[
                            AutoSizeText.rich(
                              TextSpan(
                                children: <InlineSpan>[
                                  const TextSpan(
                                    text: 'Вы пригласили ',
                                  ),
                                  TextSpan(
                                    text: '${state.count} человек',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
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
                              title: '${state.discount} %',
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
