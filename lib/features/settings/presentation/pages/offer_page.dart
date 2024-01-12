import 'package:auto_size_text/auto_size_text.dart';
import 'package:fcc_app_front/features/settings/presentation/cubit/discount_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/constants/widgets/custom_back.dart';
import '../../../../shared/constants/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/constants/colors/color.dart';
import '../widgets/offer_cart.dart';

class OfferPage extends StatelessWidget {
  const OfferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 45.w,
            vertical: 20.h,
          ),
          child: Column(
            children: [
              CustomBackButton(),
              const Spacer(),
              AutoSizeText(
                "Сколько человек я пригласил",
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
                  builder: (context, state) {
                    return Column(
                      children: [
                        AutoSizeText.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "Вы пригласили ",
                              ),
                              TextSpan(
                                text: "${state.count} человек",
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: hintColor),
                          maxLines: 1,
                        ),
                        sized10,
                        Text(
                          "Пользователи, которые зашли по вашей реферальной ссылке",
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: 12,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                        sized40,
                        OfferCart(
                          borderColor: Theme.of(context).primaryColor,
                          title: "${state.discount} %",
                          titleStyle: Theme.of(context).textTheme.titleLarge,
                          onTap: () {},
                          description: "Ваш процент скидки",
                          descriptionStyle:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
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
  }
}
