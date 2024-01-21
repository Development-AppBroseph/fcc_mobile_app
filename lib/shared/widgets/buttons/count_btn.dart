// ignore_for_file: must_be_immutable
import 'dart:async';

import 'package:fcc_app_front/export.dart';

class CounterButton extends StatefulWidget {
  CounterButton({
    Key? key,
    required this.counter,
    required this.onTap,
    this.margin,
  }) : super(key: key);

  int counter;
  final EdgeInsets? margin;
  void Function() onTap;

  @override
  State<CounterButton> createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  late Timer timer;
  bool timerFinished = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (widget.counter > 0) {
          widget.counter--;
        } else {
          timer.cancel();
          timerFinished = true;
        }
      });
    });
  }

  void resetTimer() {
    setState(() {
      timerFinished = false;
      widget.counter = 59;
      startTimer();
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      onTap: widget.onTap,
      child: Container(
        width: 300.w,
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).hintColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15),
        ),
        child: GestureDetector(
          onTap: timerFinished ? resetTimer : null,
          child: Center(
            child: Text(
              timerFinished ? 'Отправить еще раз' : "Запросить через 00:${widget.counter.toString().padLeft(2, '0')}",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    color: timerFinished ? Theme.of(context).primaryColorDark : Theme.of(context).hintColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
