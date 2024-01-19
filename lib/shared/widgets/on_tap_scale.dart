import 'dart:async';

import 'package:fcc_app_front/export.dart';

class OnTapScaleAndFade extends StatefulWidget {
  final Widget child;
  final void Function() onTap;
  final double lowerBound;
  final HitTestBehavior? behavior;
  const OnTapScaleAndFade({
    required this.child,
    required this.onTap,
    this.lowerBound = 0.85,
    this.behavior,
    Key? key,
  }) : super(key: key);

  @override
  State<OnTapScaleAndFade> createState() => _OnTapScaleAndFadeState();
}

class _OnTapScaleAndFadeState extends State<OnTapScaleAndFade> with TickerProviderStateMixin {
  double squareScaleA = 1;
  late AnimationController _controllerA;
  @override
  void initState() {
    _controllerA = AnimationController(
      vsync: this,
      lowerBound: widget.lowerBound,
      upperBound: 1.0,
      value: 1,
      duration: const Duration(milliseconds: 50),
    );
    _controllerA.addListener(() {
      setState(() {
        squareScaleA = _controllerA.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: widget.behavior ?? HitTestBehavior.translucent,
      onTap: () {
        _controllerA.reverse();
        widget.onTap();
      },
      onTapDown: (TapDownDetails dp) {
        _controllerA.reverse();
      },
      onTapUp: (TapUpDetails dp) {
        Timer(const Duration(milliseconds: 50), () {
          _controllerA.fling();
        });
      },
      onTapCancel: () {
        _controllerA.fling();
      },
      child: Transform.scale(
        scale: squareScaleA,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controllerA.dispose();
    super.dispose();
  }
}
