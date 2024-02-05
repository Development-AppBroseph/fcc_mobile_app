import 'dart:async';

import 'package:fcc_app_front/export.dart';

class CstmBtmSheet extends StatefulWidget {
  const CstmBtmSheet({
    required this.phone,
    Key? key,
  }) : super(key: key);
  final String phone;
  @override
  State<CstmBtmSheet> createState() => _CstmBtmSheetState();
}

class _CstmBtmSheetState extends State<CstmBtmSheet> {
  TextEditingController codeController = TextEditingController();
  int counter = 59;
  late Timer timer;
  bool isError = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (counter > 0) {
          counter--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Material(
        elevation: 0,
        child: Container(
          height: 880.h,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    OnTapScaleAndFade(
                      onTap: () {
                        canPopThenPop(context);
                      },
                      child: Text(
                        'Отмена',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).canvasColor,
                            ),
                      ),
                    ),
                    Text(
                      'Подтверждение',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColorDark,
                          ),
                    ),
                    Container(
                      width: 70,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 75,
              ),
              Text(
                'Код отправлен на номер',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              Text(
                widget.phone,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              sized40,
              isLoading
                  ? const SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        color: primaryColorDark,
                        strokeWidth: 3,
                      ),
                    )
                  : Pinput(
                      length: 4,
                      autofocus: true,
                      controller: codeController,
                      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      pinAnimationType: PinAnimationType.slide,
                      defaultPinTheme: const PinTheme(
                        margin: EdgeInsets.zero,
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: primaryColorDark,
                            ),
                          ),
                        ),
                      ),
                      errorBuilder: (String? errorText, String pin) => const SizedBox.shrink(),
                      showCursor: true,
                      onCompleted: (String pin) async {
                        setState(() {
                          isLoading = true;
                        });
                        final String? route = await context.read<AuthCubit>().login(
                              widget.phone,
                              pin,
                            );
                        if (route == null) isError = true;
                        if (route == RoutesNames.auth &&
                            context.mounted &&
                            Hive.box(HiveStrings.userBox).containsKey(HiveStrings.invite)) {
                          final bool isSucces = await context.read<AuthCubit>().incrementInvites(
                                widget.phone,
                                Hive.box(HiveStrings.userBox).get(HiveStrings.invite),
                              );
                          if (isSucces && context.mounted) {
                            setState(() {
                              isLoading = false;
                            });
                            context.goNamed(
                              RoutesNames.contactInfo,
                              extra: widget.phone,
                            );
                          } else if (context.mounted && route != null) {
                            setState(() {
                              isLoading = false;
                            });
                            context.goNamed(
                              route,
                              extra: widget.phone,
                            );
                          }
                        } else if (context.mounted && route != null) {
                          setState(() {
                            isLoading = false;
                          });
                          context.goNamed(
                            route,
                            extra: widget.phone,
                          );
                        } else if (context.mounted && isError) {
                          ApplicationSnackBar.showErrorSnackBar(context, 'Введен неверный код, попробуйте еще раз', 0.9,
                              const EdgeInsets.symmetric(horizontal: 10), 1);
                        }
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
              sized40,
              CounterButton(
                onTap: () {
                  context.read<AuthCubit>().createUserSendCode(
                        widget.phone,
                      );
                },
                counter: counter,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
