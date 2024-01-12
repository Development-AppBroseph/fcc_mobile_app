import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../shared/config/utils/pop_possible.dart';
import '../../../../shared/widgets/buttons/cstm_btn.dart';

class ForgotUserName extends StatelessWidget {
  const ForgotUserName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 65.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                "Не помню имя пользователя",
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                minFontSize: 15,
              ),
              SizedBox(
                height: 70.h,
              ),
              Text(
                "Перейдите по ссылке которую вам отправил в мессенджер знакомый либо запросите у него имя пользователя.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Пригласивший вас пользователь может найти свое имя пользователя по кнопке «Скидка», которая расположена в нижней панели приложения»",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 150.h,
              ),
              CstmBtn(
                onTap: () {
                  canPopThenPop(context);
                },
                text: "Продолжить",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
