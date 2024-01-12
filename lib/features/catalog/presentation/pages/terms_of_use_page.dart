import 'package:fcc_app_front/shared/config/utils/pop_possible.dart';
import 'package:flutter/material.dart';

import '../../../../shared/constants/colors/color.dart';
import '../../../../shared/widgets/buttons/cstm_btn.dart';

class TermOfUsePage extends StatelessWidget {
  const TermOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Center(
                child: Text(
                  "Условия использования",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 35, right: 35),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Вы должны прочитать и принять наши",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        TextSpan(
                          text: "Условия пользования ",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: textColor,
                              ),
                        ),
                        TextSpan(
                          text: "и ",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        TextSpan(
                          text: "Политику конфиденциальности ",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: textColor,
                              ),
                        ),
                        TextSpan(
                          text: "перед использованием продукта",
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CstmBtn(
                      onTap: () {
                        canPopThenPop(context);
                      },
                      text: "Согласен",
                      margin: const EdgeInsets.only(top: 40, left: 30, right: 30),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CstmBtn(
                      onTap: () {
                        canPopThenPop(context);
                      },
                      color: Theme.of(context).scaffoldBackgroundColor,
                      text: "Выход",
                      margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
