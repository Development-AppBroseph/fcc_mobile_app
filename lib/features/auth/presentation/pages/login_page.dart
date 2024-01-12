import 'package:fcc_app_front/shared/config/routes.dart';
import 'package:fcc_app_front/shared/constants/colors/color.dart';
import 'package:fcc_app_front/shared/constants/widgets/custom_back.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../shared/widgets/buttons/cstm_btn.dart';
import '../../../../shared/widgets/snackbar.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/cstm_bottom_sheet.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(
    initialText: '+7 ',
    mask: '+7 ###-###-##-##',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 65.w,
            ),
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  CustomBackButton(
                    path: RoutesNames.menu,
                  ),
                  SizedBox(
                    height: 100.h,
                  ),
                  Text(
                    "Введите",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    "номер телефона",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Чтобы войти или стать",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                  ),
                  Text(
                    "членом клуба ФКК",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).hintColor,
                        ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        inputFormatters: [
                          maskFormatter,
                        ],
                        keyboardType: TextInputType.number,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontFamily: "Rubik",
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                            ),
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).hintColor,
                              ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).dividerColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                        controller: phoneController,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CstmBtn(
                    width: double.infinity,
                    onTap: () async {
                      if (!maskFormatter.isFill()) {
                        ErrorSnackBar.showErrorSnackBar(
                          context,
                          "Неверный формат номера телефона",
                          0.9,
                          const EdgeInsets.symmetric(horizontal: 15),
                          3,
                        );
                      } else if (maskFormatter.isFill() && !isLoading) {
                        setState(() {
                          isLoading = true;
                        });
                        final isSuccess =
                            await context.read<AuthCubit>().createUserSendCode(
                                  maskFormatter
                                      .getMaskedText()
                                      .replaceAll(' ', '')
                                      .replaceAll('-', ''),
                                );
                        if (isSuccess && context.mounted) {
                          showCupertinoModalBottomSheet(
                            context: context,
                            expand: true,
                            builder: (context) => CstmBtmSheet(
                              phone: maskFormatter
                                  .getMaskedText()
                                  .replaceAll(' ', '')
                                  .replaceAll('-', ''),
                            ),
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    text: "Продолжить",
                    child: isLoading
                        ? Row(
                            children: [
                              Text(
                                'Продолжить',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: primaryColorDark,
                                  strokeWidth: 3,
                                ),
                              ),
                            ],
                          )
                        : null,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
