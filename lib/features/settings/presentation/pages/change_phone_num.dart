import 'package:fcc_app_front/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fcc_app_front/shared/config/utils/pop_possible.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../shared/constants/colors/color.dart';
import '../../../../shared/widgets/buttons/cstm_btn.dart';
import '../../../../shared/widgets/textfields/cstm_textfield.dart';

class ChangePhoneNum extends StatefulWidget {
  const ChangePhoneNum({super.key});

  @override
  State<ChangePhoneNum> createState() => _ChangePhoneNumState();
}

class _ChangePhoneNumState extends State<ChangePhoneNum> {
  final controller = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(
    initialText: '+7 ',
    mask: '+7 ###-###-##-##',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 30, top: 20),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 13,
                      color: primaryColorDark,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 5),
                    child: GestureDetector(
                      onTap: () {
                        canPopThenPop(context);
                      },
                      child: Text(
                        "Назад",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 50,
                      ),
                      child: Text(
                        "Введите",
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 50,
                      ),
                      child: Text(
                        "номер телефона",
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 50,
                      ),
                      child: Text(
                        "Для редактирования номера телефона",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).hintColor,
                            ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomField(
                      controller: controller,
                      contentPadding: const EdgeInsets.only(right: 20, left: 5),
                      inputFormatter: [
                        MaskTextInputFormatter(
                          mask: '+7 ###-###-##-##',
                          filter: {"#": RegExp(r'[0-9]')},
                        ),
                      ],
                      inputType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CstmBtn(
                      onTap: () async {
                        if (maskFormatter.isFill()) {
                          await context.read<AuthCubit>().changePhone(
                                maskFormatter.getMaskedText(),
                              );
                          if (context.mounted) {
                            canPopThenPop(context);
                          }
                        }
                      },
                      text: "Продолжить",
                      margin: const EdgeInsets.only(
                        left: 30,
                        right: 30,
                        top: 30,
                      ),
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
