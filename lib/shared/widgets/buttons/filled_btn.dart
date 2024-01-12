import 'package:auto_size_text/auto_size_text.dart';

import '../../constants/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../on_tap_scale.dart';

class FillBtn extends StatefulWidget {
  const FillBtn({
    super.key,
    this.height = 60,
    required this.text,
    required this.onTap,
    this.textColor,
    required this.iconPath,
    this.width = 363,
    this.textStyle,
    this.borderRadius = const BorderRadius.all(Radius.circular(15)),
    this.margin,
    this.padding,
    this.color,
    this.mainAxisAlignment = MainAxisAlignment.center,
  });
  final double height;
  final double width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final BorderRadius borderRadius;
  final Color? color;
  final Color? textColor;
  final TextStyle? textStyle;
  final String text;
  final String iconPath;
  final MainAxisAlignment mainAxisAlignment;
  final void Function() onTap;

  @override
  State<FillBtn> createState() => _FillBtnState();
}

class _FillBtnState extends State<FillBtn> {
  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      onTap: widget.onTap,
      child: Container(
        height: widget.height,
        width: widget.width,
        margin: widget.margin,
        padding: widget.padding ?? const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: widget.color ?? Theme.of(context).hintColor.withOpacity(0.05),
        ),
        child: Row(
          mainAxisAlignment: widget.mainAxisAlignment,
          children: [
            SvgPicture.asset(
              widget.iconPath,
              width: 24,
              height: 24,
            ),
            Expanded(
              child: AutoSizeText(
                widget.text,
                style: widget.textStyle ??
                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: widget.textColor ?? Theme.of(context).primaryColorDark,
                        ),
                maxLines: 1,
                minFontSize: 10,
                textAlign: TextAlign.center,
              ),
            ),
            sized20,
          ],
        ),
      ),
    );
  }
}
