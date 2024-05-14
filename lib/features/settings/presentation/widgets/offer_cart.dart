import 'package:auto_size_text/auto_size_text.dart';
import 'package:fcc_app_front/shared/constants/colors/color.dart';
import 'package:fcc_app_front/shared/widgets/on_tap_scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OfferCart extends StatefulWidget {
  const OfferCart({
    super.key,
    this.height = 118,
    this.width = 363,
    this.padding,
    this.showIcon = true,
    this.titleStyle,
    this.titlePadding,
    this.borderColor,
    this.descriptionStyle,
    this.imagePath,
    required this.title,
    required this.onTap,
    required this.description,
    this.margin,
    this.icon,
    this.color = scaffoldBackgroundColor,
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
  });
  final double height;
  final double width;
  final String title;
  final String description;
  final String? imagePath;
  final Color? color;
  final Icon? icon;
  final bool showIcon;
  final Color? borderColor;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final BorderRadius borderRadius;
  final EdgeInsets? padding;
  final EdgeInsets? titlePadding;
  final EdgeInsets? margin;
  final Function() onTap;

  @override
  State<OfferCart> createState() => _OfferCartState();
}

class _OfferCartState extends State<OfferCart> {
  @override
  Widget build(BuildContext context) {
    return OnTapScaleAndFade(
      onTap: widget.onTap,
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Theme.of(context).hintColor.withOpacity(0.05),
              blurRadius: 46,
            )
          ],
          border: Border.all(
            color: primaryColor,
            width: 1.5,
          ),
          borderRadius: widget.borderRadius,
        ),
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor.withOpacity(0.35),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/offer.svg',
                  height: 50,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: widget.titleStyle ??
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                  ),
                  AutoSizeText(
                    'Ваш процент скидки',
                    maxLines: 1,
                    style: widget.descriptionStyle ??
                        Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w400, fontSize: 7),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
